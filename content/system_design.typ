#import "/utils/todo.typ": TODO
#import "../utils/icons.typ": check, cross

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


== Persistent Data Management
#TODO[
  Optional section that describes how data is saved over the lifetime of the system and which data. Usually this is either done by saving data in structured files or in databases. If this is applicable for the thesis, describe the approach for persisting data here and show a UML class diagram how the entity objects are mapped to persistent storage. It contains a rationale of the selected storage scheme, file system or database, a description of the selected database and database administration issues.
]
As a Spring Boot application, Artemis' server persists data in the database as entities using Spring Data repositories. In the following section we describe how we extend Artemis' persistence model with two new entities for the implementation of calendar subscriptions and the exercise planning functionality. Those entities persist the token needed to authenticate third party calendar applications to enable them to access the iCalendar subscription endpoint, as well as the data needed to plan Exercises. To enable Artemis to display Derived Events we required no new entities since, as the name indicates, Derived Event are derived from already existing entities.

#v(1em)
#figure(
      image(
        "../figures/CalendarSubscriptionTokenStoreClassDiagram.svg",
      ),
      caption: [Class diagram showing the entities used to store subscription tokens],
)<tokenStoreClassDiagram>
#v(1em)

To implement iCalendar subscriptions in Artemis, third-party apps use a URL pointing to a REST endpoint that serves an .ics file with events. Because the iCalendar standard lacks an authentication mechanism, the server cannot authorize requests or return user-specific events by default. We solve this by embedding a user authentication token into the subscription URL that the user configures in the third-party app.

@tokenStoreClassDiagram shows the UML class diagram of the entities involved in storing this token. Each token belongs to exactly one user. We decided not to store the token directly in the User entity. Many requests in Artemis load user data without needing the token, and including it would cause the database to repeatedly fetch unnecessary data. Moreover, the token is created only when a user sets up their first subscription, not when the user account is created. Adding a dedicated token column to the User table would therefore produce a large number of null entries—wasting space and potentially harming performance.

Instead, we store tokens in a dedicated entity, CalendarSubscriptionTokenStore, which holds a unidirectional reference to User. This relation lets us retrieve the user for a given token and avoid extending the User entity entirely. We enforce the token to be unique and non-null in the database. The uniqueness constraint automatically creates an index on the token field. This index both guarantees uniqueness and speeds up queries that resolve a user by token.

#figure(
      image(
        "../figures/PlannedExerciseClassDiagram.svg",
      ),
      caption: [Class diagram showing the entities used to store Planned Exercises],
)<plannedExerciseClassDiagram>

The Exercise entity in Artemis has a title property of type string and four date properties called releaseDate, startDate, dueDate, and assessmentDueDate. To plan an exercise, we want to specify exactly these properties without defining any additional information. To persist this data for a given exercise, we encapsulate the properties in a new entity called PlannedExercise. Each PlannedExercise is associated to one Course.

Similar to the User entity, the Course entity is already relatively large. To avoid the same issues described earlier, we use the same approach and define a unidirectional relation from PlannedExercise to Course. The database implements this relation by storing a foreign key that references a Course in the PlannedExercise table. To support efficient lookups of all PlannedExercise instances belonging to a specific course, we create an index on this foreign key.

We also want to return PlannedExercise instances in a defined order. In our business logic, we guarantee that at least one of the date properties is non-null. We sort planned exercises by date, considering the first non-null date property of each instance. To make this sorting efficient in database queries, we create a multidimensional index on the date properties. Finally, we enforce a non-null constraint on the title property at the database level.

== Access Control
#TODO[
  Optional section describing the access control and security issues based on the quality attributes and constraints. It also de- scribes the implementation of the access matrix based on capabilities or access control lists, the selection of authentication mechanisms and the use of en- cryption algorithms.
]
We now focus on how we control access to the resources introduced in this thesis. The Artemis server exposes REST endpoints that let users perform CRUD operations on data. In the following section, we explain how we ensure that users interact only with data they are authorized to access, discussing each implemented endpoint. For clarity, @calendarAccessMatrix and @lectureScaffoldingAndExercisePlanningAccessMatrix summarize which user roles can access which functionality through access matrices.

To support the calendar feature, we create GET endpoints for retrieving subscription tokens, .ics files for subscriptions, and events for the calendar itself. The subscription token endpoint requires authentication and verifies that the authenticated user has at least the student role. As a result, all students can retrieve their token.

Both the subscription and event endpoints return events for a given courseId. The event endpoint returns them as DTOs, while the subscription endpoint converts them into an .ics file. Both endpoints require authentication and verify that the user is at least a student of the given course. The server then determines which events to return based on the user’s identity and role in the course. It returns events of released Lectures, Exercises, and Exams for all course roles. It only returns Tutorial events related to a specific Tutorial Group for Students and Tutors who are part of this group. Additionally, it returns events of unreleased Lectures, Exercises, and Exams only for Admins, Instructors, Editors, and Tutors. @calendarAccessMatrix summarizes the access control for this functionality.

#figure(
  caption: [Access Control Matrix for the calendar],
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
    [Get released Lecture events], [#check], [#check], [#check], [#check], [#check],
    [Get released Exercise events], [#check], [#check], [#check], [#check], [#check],
    [Get released Exam events], [#check], [#check], [#check], [#check], [#check],
    [Get Tutorials Events], [#cross], [#cross], [#cross], [#check], [#check],
    [Get unreleased Lecture events], [#check], [#check], [#check], [#check], [#cross],
    [Get unreleased Exercise events], [#check], [#check], [#check], [#check], [#cross],
    [Get unreleased Exam events], [#check], [#check], [#check], [#check], [#cross],
  )
)<calendarAccessMatrix>

To implement lecture series scaffolding, we add an endpoint that lets users create lecture series for a given course. The endpoint requires authentication and verifies that the user has at least the editor role in the course.

To support exercise planning, we add endpoints for creating single Planned Exercises and Planned Exercise series, retrieving all Planned Exercises, updating a Planned Exercise, and deleting a Planned Exercise. Each endpoint expects a courseId that associates the involved objects with a course. All endpoints require authentication and verify that the user is at least an editor in the given course, except for the DELETE endpoint, which requires the user to have at least the instructor role. @lectureScaffoldingAndExercisePlanningAccessMatrix summarizes the access control logic for lecture scaffolding and exercise planning.

#figure(
  caption: [Access Control Matrix for Lecture Scaffolding and Exercise Planning],
  table(
    columns: (7fr, 1.8fr, 2.1fr, 1.8fr, 1.8fr, 1.8fr),
    align: (left, center, center, center, center, center),
    table.header(
      [Functionality],
      [Admin],
      [Instructor],
      [Editor],
      [Tutor],
      [Student]
    ),
    [Create Lecture series], [#check], [#check], [#check], [#cross], [#cross],
    [Get Planned Exercises], [#check], [#check], [#check], [#cross], [#cross],
    [Create single Planned Exercise], [#check], [#check], [#check], [#cross], [#cross],
    [Create Planned Exercise series], [#check], [#check], [#check], [#cross], [#cross],
    [Update Planned Exercise], [#check], [#check], [#check], [#cross], [#cross],
    [Delete Planned Exercise], [#check], [#check], [#cross], [#cross], [#cross],
    [Create Exercise using Planned Exercise], [#check], [#check], [#check], [#cross], [#cross],
  )
)<lectureScaffoldingAndExercisePlanningAccessMatrix>

#pagebreak()