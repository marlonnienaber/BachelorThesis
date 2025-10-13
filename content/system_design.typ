#import "/utils/todo.typ": TODO
#import "../utils/icons.typ": check, cross

= Architecture<architecture>
#TODO[
  This chapter follows the System Design Document Template in @bruegge2004object. You describe in this chapter how you map the concepts of the application domain to the solution domain. Some sections are optional, if they do not apply to your problem. Cite @bruegge2004object several times in this chapter.
]
The following chapter documents the transfer of application domain concepts from @requirements into the solution domain. It follows the System Design Document Template described by Brügge et al. #cite(<Brue2014>). @architectureOverview provides a brief overview of Artemis’ architecture and outlines the planned extensions required to implement the proposed feature. @designGoals derives the design goals by considering the quality attributes and constraints defined in @requirements, along with additional aspects relevant to the implementation. Finally, @subsystemDecomposition presents the subsystem decomposition of the calendar feature.


== Overview<architectureOverview>
#TODO[
  Provide a brief overview of the software architecture and references to other chapters (e.g. requirements), references to existing systems, constraints impacting the software architecture..
]
Artemis is an open-source web application, separated into a client and a server. The client uses the Angular framework from the TypeScript ecosystem, while the server makes use of Spring Boot, which is a Java framework. Client and server communicate mainly through a representational state transfer application programming interface (REST API). Both the Artemis client and server consist of multiple modules that internally follow a layered architecture. Each layer bundles multiple classes and separates them by concerns.

The client modules contain a user interface layer and a service layer. When the user performs an operation on entities managed by the system, the user interface layer receives the input that triggers the operation. It then calls the service layer, which sends an HTTP request to the server. The server modules consist of three layers. The web layer receives client requests and forwards them to the service layer. The service layer applies business logic to process the requests. To perform the operations, it calls the repository layer, which provides access to the database. The layers then propagate back the response to the request in the opposite direction. To implement the new feature, we operate on several entities managed by the server, namely Lectures, Exercises, Tutorial Groups, Tutorial Group Sessions, and Exams. 

== Design Goals<designGoals>
#TODO[
  Derive design goals from your quality attributes and constraints, prioritize them (as they might conflict with each other) and describe the rationale of your prioritization. Any trade-offs between design goals (e.g., build vs. buy, memory space vs. response time), and the rationale behind the specific solution should be described in this section
]
Before presenting the implementation details of the calendar feature, this section specifies the design goals and discusses the trade-offs that arise between them. The design goals define the qualities of the system that we want to optimize during implementation #cite(<Brue2014>). They build on the quality attributes and constraints defined in @requirements while also considering additional aspects.

==== Performance vs. Functionality
Artemis currently serves several tens of thousands of users, which can put significant load on the system. To keep the calendar feature performant (QA8–9), the design focuses on minimizing response times of the REST endpoints. This aspect is particularly important for the iCalendar subscription endpoint, which external calendar applications call at regular intervals. Database calls represent the primary bottleneck affecting response time. The code, therefore, minimizes the number of queries, optimizes their definitions, and fetches only the required data. To achieve this, the implementation defines DTOs and constructs them directly within the queries, rather than loading complete entities.

Further performance optimization would be possible through the use of caching strategies. However, this optimization conflicts with a second design goal — implementing as much functionality defined in @requirements as possible. Given limited time, the design prioritizes functionality over performance and excludes caching from the current scope. Instead, we monitor the system’s performance in its current state and defer the implementation of caching to a later stage if necessary.

==== Dependability
Given Artemis’s large user base, robustness is also a critical concern. The system must remain responsive and avoid entering unrecoverable states. To ensure this, it must handle and resolve errors effectively and tolerate delays when fetching data (QA5-7).

==== Maintenance
A team of constantly changing developers works on Artemis. The code base of the project has significant size and is constantly evolving. To promote extensibility and modifiability, we take two measures. First, we want to provide comprehensive and detailed documentation of the newly introduced feature (QA13). Second, the code should adhere to Artemis coding guidelines (QA14) to ensure a high quality standard and thereby make the code easy to understand, modify, and extend.

==== End User Criteria vs. Functionality
The calendar feature should aim to promote usability by keeping its components easy to access (QA1–3) and by following an adaptive design suitable for both large and small devices (QA4). Additionally, the calendar should support text in both English and German (QA11) and display dates accurately across different time zones (QA10).

Sometimes the usability goal conflicts with the goal of broad functionality, for example, when planning exercises or creating a lecture series. Here, more configuration options increase flexibility but also add complexity. We decide to prioritize ease of use: The user interface hides most properties by default and fills required fields with sensible values. Users can open a submenu for individual exercises or lectures to adjust a selection of details. The user can handle less critical configurations later through the course management.

== Subsystem Decomposition<subsystemDecomposition>
#TODO[
  Describe the architecture of your system by decomposing it into subsystems and the services provided by each subsystem. Use UML class diagrams including packages / components for each subsystem.
]
The following section outlines the architectural extensions that enable the calendar functionality in Artemis. Two component diagrams illustrate the modified and newly introduced components within the relevant subsystems. In the figures, new components appear in blue, while adapted ones appear in green. To keep the figures readable, the diagrams omit the module-level separation of components and instead illustrate separation only by layers. We begin by describing the server's architecture, and then proceed to the client.

@calendarClientComponentDiagram illustrates the client architecture. The calendar's user interface extends the *User Interface Layer* with two new components: *CalendarDesktopOverviewComponent* and *CalendarMobileOverviewComponent*. The client displays one of them depending on the device's screen size. The mobile component targets small devices, such as phones, while the desktop component suits larger screens, like laptops. Both components present events in either a high-level overview or a detailed view. Users can navigate through time, jump to today, and open a popover to configure subscriptions.

To display events and create subscriptions, the client requires event data and a subscription token from the server. To retrieve this data through HTTP requests and cache the results, the client's *Service Layer* now includes the *CalendarService*. During initialization, the service obtains the user's subscription token. When needed, it loads events for the selected month as well as for the adjacent months. The user interface components bind to the service using Angular's Signals API, enabling a reactive, observer-pattern-style data flow.

#figure(
      image(
        "../figures/CalendarClientComponentDiagram.svg",
      ),
      caption: [Client subsystem decomposition model (UML component diagram)],
)<calendarClientComponentDiagram>

@calendarServerComponentDiagram shows the server architecture. The *Web Layer* now includes the *CalendarResource*, which exposes three REST endpoints: two serve the Artemis client — one for events and one for calendar subscription tokens. A third endpoint delivers .ics files to external systems, enabling iCalendar subscriptions.

The event and subscription endpoints rely on several services in the server’s *Service Layer*. Some of these services are needed to assemble DTOs representing events. @calendarServerComponentDiagram groups them as the *Event Services* subsystem to avoid clutter. This subsystem includes the *TutorialGroupService*, *ExamService*, *LectureService*, *QuizExerciseService* and *ExerciseService*. The subscription endpoint additionally relies on the *CalendarSubscriptionService* to convert event DTOs into .ics files. 

The services from the event services subsystem depend on several repositories in the *Repository Layer* to retrieve data from the database that is required to assemble event DTOs. @calendarServerComponentDiagram aggregates these repositories into the *Event Repositories* subsystem to improve readability. This subsystem includes the *TutorialGroupRepository*, *TutorialGroupSessionRepository*, *LectureRepository*, *ExamRepository*, *QuizExerciseRepository* and *ExerciseRepository*. We extend these repositories with database queries to supply the data required by the services.

Finally, the Repository Layer includes the new *CalendarSubscriptionTokenStoreRepository*. The subscription token endpoint depends on it to retrieve the subscription token for the logged-in user. If no such token exists, the endpoint calls the *CalendarSubscriptionService* to generate one, stores it through the *CalendarSubscriptionTokenStoreRepository*, and returns it to the Artemis client.

#figure(
      image(
        "../figures/CalendarServerComponentDiagram.svg",
      ),
      caption: [Server subsystem decomposition model (UML component diagram)],
)<calendarServerComponentDiagram>


== Persistent Data Management
#TODO[
  Optional section that describes how data is saved over the lifetime of the system and which data. Usually this is either done by saving data in structured files or in databases. If this is applicable for the thesis, describe the approach for persisting data here and show a UML class diagram how the entity objects are mapped to persistent storage. It contains a rationale of the selected storage scheme, file system or database, a description of the selected database and database administration issues.
]
As a Spring Boot application, Artemis' server persists data in the database as entities using Spring Data repositories. The subsequent section describes how the implementation of calendar subscriptions extends Artemis' persistence model with a new entity. This entity stores the token required for authenticating third-party calendar applications, allowing them to access the iCalendar subscription endpoint. Enabling Artemis to display derived events requires no additional entities, since, as the name indicates, derived events are derived from already existing entities.

#v(1em)
#figure(
      image(
        "../figures/CalendarSubscriptionTokenStoreClassDiagram.svg",
      ),
      caption: [Entities used to store subscription tokens (UML class diagram)],
)<tokenStoreClassDiagram>
#v(1em)

To implement iCalendar subscriptions in Artemis, third-party apps use a URL pointing to a REST endpoint that serves an .ics file with events. Because the iCalendar standard lacks an authentication mechanism, the server cannot, by default, authorize requests or return user-specific events. We solve this by embedding an authentication token into the subscription URL that the user configures in the third-party app.

@tokenStoreClassDiagram shows the UML class diagram of the entities involved in storing this token. Each token belongs to exactly one user. We decided not to store the token directly in the user entity. Many requests in Artemis load user data without needing the token, and including it would cause the database to repeatedly fetch unnecessary data. Moreover, the token is created only when a user sets up their first subscription, not when the user account is created. Adding a dedicated token column to the user table would therefore produce a large number of null entries—wasting space and potentially harming performance.

Instead, the system stores tokens in a dedicated entity called CalendarSubscriptionTokenStore, which holds a unidirectional relation to the user entity. This relation enables the retrieval of the user for a given token without extending the user entity itself. We enforce the token to be unique and non-null in the database. The uniqueness constraint automatically creates an index on the token field. This index both guarantees uniqueness and speeds up queries that resolve a user by token.

== Access Control
#TODO[
  Optional section describing the access control and security issues based on the quality attributes and constraints. It also de- scribes the implementation of the access matrix based on capabilities or access control lists, the selection of authentication mechanisms and the use of en- cryption algorithms.
]
The following paragraphs focuses on controlling access to the resources introduced in this thesis. The Artemis server exposes RESTful endpoints that enable users to perform CRUD operations on data. This section explains how the system ensures that users interact only with data they are authorized to access, discussing each implemented endpoint. For clarity, @accessControlMatrix summarizes which user roles can access specific functionality through an access matrix.

To support the calendar feature, the system provides GET endpoints for retrieving subscription tokens, .ics files for subscriptions, and calendar events. The subscription token endpoint requires authentication and verifies that the authenticated user has at least the student role. As a result, all students can retrieve their token.

Both the subscription and event endpoints return events for a given courseId. The event endpoint returns them as DTOs, while the subscription endpoint converts them into an .ics file. Both endpoints require authentication and verify that the user is at least a student of the given course. The server then determines which events to return based on the user’s identity and role in the course. It returns events of lectures, released exercises, and released exams for all course roles. It only returns tutorial events related to a specific tutorial group for students and tutors who are part of this group. Additionally, it returns events of unreleased exercises and exams only for admins, instructors, editors, and tutors.

To implement lecture series scaffolding, the system features an endpoint that allows users to create lecture series for a specific course. The endpoint requires authentication and checks that the user has at least the editor role in the course. When creating a lecture series, the system assigns default names to lectures using the format “Lecture index”, where index reflects the lecture’s chronological position. Before saving the series, the system prompts the user whether they would like to rename existing lectures that follow the default naming pattern to match the new order introduced by the additional lectures. A second endpoint enables renaming lectures for a given course and applies the same authentication and role verification.

#figure(
  caption: [Access control matrix for implemented functionality],
  table(
    columns: (7fr, 1.8fr, 2.1fr, 1.8fr, 1.8fr, 1.8fr),
    align: (left, center, center, center, center, center, center),
    table.header(
      [Functionality],
      [Admin],
      [Instructor],
      [Editor],
      [Tutor],
      [Student],
    ),
    [Get subscription token], [#check], [#check], [#check], [#check], [#check],
    [Get released lecture events], [#check], [#check], [#check], [#check], [#check],
    [Get released exercise events], [#check], [#check], [#check], [#check], [#check],
    [Get released exam events], [#check], [#check], [#check], [#check], [#check],
    [Get tutorials Events], [#cross], [#cross], [#cross], [#check], [#check],
    [Get unreleased lecture events], [#check], [#check], [#check], [#check], [#cross],
    [Get unreleased exercise events], [#check], [#check], [#check], [#check], [#cross],
    [Get unreleased exam events], [#check], [#check], [#check], [#check], [#cross],
    [Create lecture series], [#check], [#check], [#check], [#cross], [#cross],
    [Update lecture names], [#check], [#check], [#check], [#cross], [#cross],
  )
)<accessControlMatrix>

#pagebreak()