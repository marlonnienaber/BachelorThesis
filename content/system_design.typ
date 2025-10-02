#import "/utils/todo.typ": TODO

= Architecture<architecture>
#TODO[
  This chapter follows the System Design Document Template in @bruegge2004object. You describe in this chapter how you map the concepts of the application domain to the solution domain. Some sections are optional, if they do not apply to your problem. Cite @bruegge2004object several times in this chapter.
]
The following chapter describes how we transfer application domain concepts from @requirements into the solution domain. It is based on the System Design Document Template described by Brügge et al. #cite(<Brue2014>). In @architectureOverview, we first give a brief overview of Artemis' architecture and how we intend to extend it to implement the proposed feature. We then derive design goals in @designGoals by taking into account the quality attributes and constraints defined in @requirements, as well as additional aspects that are important in the context of the implementation. After that we describe the subsystem decomposition of the calendar feature in @subsystemDecomposition.


== Overview<architectureOverview>
#TODO[
  Provide a brief overview of the software architecture and references to other chapters (e.g. requirements), references to existing systems, constraints impacting the software architecture..
]
Artemis is an open-source web application separated into a client and a server. The client uses the Angular framework from the TypeScript ecosystem, while the server makes use of Spring Boot which is a Java framework. Client and server communicate mainly through a representational state transfer application programming interface (REST API). Artemis applies a layered architecture across the entire application stack. Each layer bundles multiple classes and separates them by concerns.

The client contains a user interface layer and a service layer. When the user performs an operation on entities managed by the system, the user interface layer receives the input that triggers the operation. It then calls the service layer, which sends an HTTP request to the server.

The server contains three layers. The web layer receives client requests and forwards them to the service layer. The service layer applies business logic to process the requests. To perform the operations, it calls the repository layer, which provides access to the database. The layers then propagate the response to the request back in opposite direction. For implementing the new feature we will operate on several entities managed by the server, namely Lectures, Exercises, TutorialGroups, TutorialGroupSessions, and Exams. 

== Design Goals<designGoals>
#TODO[
  Derive design goals from your quality attributes and constraints, prioritize them (as they might conflict with each other) and describe the rationale of your prioritization. Any trade-offs between design goals (e.g., build vs. buy, memory space vs. response time), and the rationale behind the specific solution should be described in this section
]
Before presenting the implementation details of the calendar feature, we want to specify our design goals and discuss trade-offs that arise between them. We thereby define the qualities of the system that we want to optimize during implementation #cite(<Brue2014>). For developing the design goals we take into account the quality attributes and constraints defined in @requirements but also additional aspects.

==== Performance vs. Functionality
Artemis currently has several tens of thousands of users, which can put significant load on the system. To keep the calendar feature performant (QA11-13), we focus on minimizing response times of the REST endpoints. This is especially important for the iCalendar subscription endpoint that external calendar applications call in repeated intervals. Database calls are the primary bottleneck determining response time. We therefore minimize the number of queries, optimize their definitions, and fetch only the required data. To achieve this, we define DTOs and construct them directly in the queries instead of loading complete entities.

We could further optimize performance by applying caching strategies. However, this conflicts with a second design goal: implementing as much functionality defined by the requirements from @requirements as possible. Because of limited time, we prioritize functionality over performance and exclude caching from this thesis. Instead, we monitor the system’s performance in its current state and defer the implementation of caching to a later stage if necessary.

==== Dependability
Given Artemis’s large user base, robustness is also a critical concern. We want to prevent the system from becoming unresponsive or entering unrecoverable states. To achieve this, we specifically require the system to handle and resolve errors and to tolerate delays when fetching data (QA5-10).

==== Maintenance
A team of constantly changing developers works on Artemis. The code base of the project has significant size and is constantly evolving. To promote extensibility and modifiability, we take two measures. First, we want to provide comprehensive and detailed documentation of the newly introduced feature (QA17). Second, we want to adhere to Artemis coding guidelines (QA18) to ensure a high code quality standard and thereby make the code easy to understand, modify, and extend.

==== End User Criteria vs. Functionality
We want to ensure good usability of the calendar feature by adhering to the UI/UX guidelines of the chair of Applied Education Technologies (QA1-2). Beyond that, the calendar must support text in English and German (QA15), display dates correctly across time zones (QA14), and allow to adjust the week start to Monday or Sunday to adapt to the user's locale convention (QA16).

Sometimes the usability goal conflicts with the goal of broad functionality, for example, when planning exercises or creating a lecture series. Here, more configuration options increase flexibility but also add complexity. We decide to prioritize ease of use: The user interface hides most properties by default and fills required fields with sensible values. Users can open a submenu for individual exercises or lectures to adjust a selection of details. The user can handle less critical configurations later through the course management.

== Subsystem Decomposition<subsystemDecomposition>
#TODO[
  Describe the architecture of your system by decomposing it into subsystems and the services provided by each subsystem. Use UML class diagrams including packages / components for each subsystem.
]
We now outline how we extend Artemis’ architecture to implement the calendar feature. We present the altered and newly added components of the involved subsystems. First we start by describing the subsystem decomposition of the client, then we move on to the server.

@clientComponentDiagram shows the architecture of the client. We implement the calendar’s user interface by extending the User *Interface Layer* of the client with two new components: the *CalendarDesktopOverviewComponent* and *CalendarMobileOverviewComponent*. The client conditionally displays one of the two depending on the device’s screen size. The mobile component is optimized for small devices such as mobile phones, while the desktop component is suited for larger screens such as laptops. Both components display events either in a high-level overview or in a detailed view. Users can navigate backwards and forwards in time, jump to today, and open a popover to configure subscriptions.

To display events and create subscriptions, the client requires event data and a subscription token from the server. We add the *CalendarService* to the client’s *Service Layer*. It fetches the data via HTTP requests and caches them. On initialization, the service retrieves the user’s subscription token. On demand, it loads events for a target month as well as the preceding and following months. To feed this data reactively into the UI, we bind the user interface components to the service using Angular’s signals API. We thereby implement an observer pattern style data flow.

#figure(
      image(
        "../figures/ClientComponentDiagram.svg",
      ),
      caption: [Component diagram showing the client subsystem],
)<clientComponentDiagram>

@serverComponentDiagram shows the server architecture. We extend the server’s *Web Layer* with the *CalendarResource*. It exposes three REST endpoints: two serve the Artemis client — one for events and one for calendar subscription tokens. A third endpoint delivers .ics files to external systems enabling iCalendar subscriptions.

The event and subscription endpoints rely on several services in the server’s *Service Layer*. Some of these services are needed to assemble DTOs representing events. In @serverComponentDiagram, we group them as the *Event Services* subsystem to avoid clutter. This subsystem includes the *TutorialGroupService*, *ExamService*, *LectureService*, *QuizExerciseService* and *ExerciseService*. The subscription endpoint additionally relies on the *CalendarSubscriptionService* to convert event DTOs into .ics files. 

The services from the Event Services subsystem depend on several repositories in the *Repository Layer* to retrieve data from the database that are required to assemble event DTOs. In @serverComponentDiagram, we aggregate these repositories into the *Event Repositories* subsystem to keep the diagram tidy. This subsystem includes the *TutorialGroupRepository*, *TutorialGroupSessionRepository*, *LectureRepository*, *ExamRepository*, *QuizExerciseRepository* and *ExerciseRepository*. We extend these repositories with database queries to supply the data required by the services.

Finally, we add the *CalendarSubscriptionTokenStoreRepository* to the Repository Layer. The the subscription token endpoint depends on it to retrieve the subscription token for the logged-in user. If no such token exists, the endpoint calls the *CalendarSubscriptionService* to generate one, store it through the *CalendarSubscriptionTokenStoreRepository*, and return it to the Artemis client.

#figure(
      image(
        "../figures/ServerComponentDiagram.svg",
      ),
      caption: [Component diagram showing the server subsystem],
)<serverComponentDiagram>

== Hardware Software Mapping
#TODO[
  This section describes how the subsystems are mapped onto existing hardware and software components. The description is accompanied by a UML deployment diagram. The existing components are often off-the-shelf components. If the components are distributed on different nodes, the network infrastructure and the protocols are also described.
]

== Persistent Data Management
#TODO[
  Optional section that describes how data is saved over the lifetime of the system and which data. Usually this is either done by saving data in structured files or in databases. If this is applicable for the thesis, describe the approach for persisting data here and show a UML class diagram how the entity objects are mapped to persistent storage. It contains a rationale of the selected storage scheme, file system or database, a description of the selected database and database administration issues.
]

== Access Control
#TODO[
  Optional section describing the access control and security issues based on the quality attributes and constraints. It also de- scribes the implementation of the access matrix based on capabilities or access control lists, the selection of authentication mechanisms and the use of en- cryption algorithms.
]

== Global Software Control
#TODO[
  Optional section describing the control flow of the system, in particular, whether a monolithic, event-driven control flow or concurrent processes have been selected, how requests are initiated and specific synchronization issues
]

== Boundry Conditions
#TODO[
  Optional section describing the use cases how to start up the separate components of the system, how to shut them down, and what to do if a component or the system fails.
]
