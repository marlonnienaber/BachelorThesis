#import "/utils/todo.typ": TODO

= Requirements<requirements>
#TODO[
  This chapter follows the Requirements Analysis Document Template in @bruegge2004object. Important: Make sure that the whole chapter is independent of the chosen technology and development platform. The idea is that you illustrate concepts, taxonomies and relationships of the application domain independent of the solution domain! Cite @bruegge2004object several times in this chapter.
]
The following chapter elicits the requirements of the proposed system. It is based on the Requirements Analysis Document Template described by Brügge et al. #cite(<Brue2014>). @requirementsOverview provides an overview of the proposed system. @existingSystem then expands on the current time management infrastructure in Artemis. Next, @proposedSystem details the feature introduced in this thesis by analyzing its requirements in the context of the FURPS+ model described by Brügge et al. Finally, @systemModel develops specific aspects of the proposed system by illustrating selected scenarios, extracting use cases, modeling relevant objects, and showcasing the design of the user interface.

== Overview<requirementsOverview>
#TODO[
  Provide a short overview about the purpose, scope, objectives and success criteria of the system that you like to develop.
]
The proposed feature adds a calendar to the course overview. In it, users can inspect events relevant to them within the context of a course. The calendar has two variants: one optimized for small devices, such as mobile phones, and one designed for larger devices, like laptops. Users can also subscribe external calendar applications to the Artemis calendar via iCalendar subscriptions. 

The calendar includes two categories of events. The first consists of events automatically derived from Artemis entities such as lectures, tutorial group sessions, exams, exercises, and planned exercises. Planned exercises are proxies for exercises. We want to enable instructors and editors to create them, allowing for the display of exercise events before the actual exercise is created. We also want to provide a way to quickly scaffold a series of lectures without specifying their contents, to make lecture events available early. Secondly, course staff members can manage so-called administrative events in a schedule component that is part of the course management to support organizational matters.

== Existing System<existingSystem>
Artemis does not yet provide a feature that specifically supports time management. Instead, managing tasks in the context of a course often requires users to log in and navigate to a specific component to check a specific date: Students, for example, have to navigate to exercise pages to check working times and visit lecture, exam, and tutorial pages to see when those take place.

Sometimes, users must rely on external tools for time management because course-related materials, such as exercises or lectures, are not yet released, and the corresponding dates are therefore not available in Artemis. At TUM, for example, courses often have
regular exercise release dates that are published on Moodle, but these dates only appear in Artemis once a course staff member creates the exercise — often just a few days before the actual release.

External tools are also necessary for planning administrative matters, such as course staff meetings, since Artemis does not currently provide functionality to create such events. Without a centralized location that lists all important events, time management in Artemis can be cumbersome and inefficient at times.
#TODO[
  This section is only required if the proposed system (i.e. the system that you develop in the thesis) should replace an existing system.
]

== Proposed System<proposedSystem>
To address this problem, this thesis integrates a time management feature into Artemis. The centerpiece of this feature is a calendar that is part of the course overview. 

The calendar follows an event-oriented approach, as its aim is not to dictate when users complete specific tasks, unlike a task-oriented solution. Instead, the calendar should inform users about the temporal structures that influence their independent task scheduling. In other words, the calendar provides the necessary information to empower users to manage their own time effectively. This conception matches precisely the idea of an event-oriented calendar and is in line with Artemis' flexible blended learning approach.

Integrating the calendar at the course level is preferable compared to a global calendar that combines events from all courses. This is because a global calendar would quickly become overcrowded and difficult to use. Limiting the scope to a single course also enables more meaningful color coding, with colors used to distinguish between event types rather than between courses.

The calendar supports multiple ways to view events. At a high level, the month presentation shows which events occur on each day. For more detail, users can drill down to see when events take place: On larger devices, they can use a week presentation that displays the selected week, while on smaller devices, a day presentation provides an overview of a single day.

The calendar also lets users configure iCalendar subscriptions. The user can choose to include or exclude event types (lecture, exercise, tutorial, exam, or administrative events) and select the event language (English or German). This way, the user can create an arbitrary number of subscriptions with different configurations, allowing them to use separate subscriptions for different devices.

As already mentioned, the time management feature primarily displays derived events that represent important dates of existing entities such as lectures, exercises, exams, and tutorials. This is, of course, not possible for entities that instructors and editors have not yet created. We aim to solve this problem in two different ways. 

We aim to enable instructors and editors to scaffold a series of lectures by specifying only minimal information (e.g., title, timing) and adding content to the lectures later in the course management. For exercises, we must take a different approach, as it is not possible to create them independently of their content. Instead, we would like users to be able to create planned exercises by again specifying minimal information. These planned exercises then act as proxies for real exercises. Once an instructor or editor creates an exercise, they can automatically populate the title and dates of the exercise by choosing a planned exercise, and the system subsequently discards the planned exercise.

In addition to derived events, the feature introduces a second type: administrative events. Course staff members (instructors, editors, and tutors) can create, update, and delete these events in a dedicated schedule within the course management system. Administrative events are visible only to course staff members and support the coordination of organizational tasks. The schedule presents administrative and all other course-related events in a chronological list, serving as a shared mental model of the course for the teaching team.

=== Functional Requirements<functionalRequirements>
We now analyze the functional requirements of the proposed feature. Functional requirements define the functionality that the system must support by describing how the system interacts with the user and external systems #cite(<Brue2014>). We split the functional requirements into a section describing the calendar itself, and a section containing all functionality that supports the display of lecture, exercise, and administrative events:

==== Calendar Requirements
- FR1 *Inspect events in overview presentation*: The user can inspect events in a high level overview that represents the currently selected month.
- FR2 *Inspect events in detail presentation*: The user can drill down from the overview to inspect events in a more detailed presentation that allows to see the timing of events on the day that they occur.
- FR3 *Inspect event details*: The user can inspect details about an event by clicking on it in the calendar.
- FR4 *Navigate backwards in time*: The user can navigate to the previous instance of the currently selected presentation.
- FR5 *Navigate forward in time*: The user can navigate to the next instance of the currently selected presentation.
- FR6 *Navigate to today*: The user can navigate to the instance of the currently selected presentation that contains the current day with one click.
- FR7 *Filter events*: The user can filter out any event type in the currently selected presentation. To do this a filter component is available that supports filtering by lecture, exercise, tutorial, exam and administrative events.
- FR8 *Copy subscription link*: The user can copy an iCalendar subscription URL to subscribe external calendar applications to the Artemis calendar.
- FR9 *Configure events for subscription*: The user can configure the subscription URL to include or exclude lecture, exercise, tutorial, exam and administrative events.
- FR10 *Configure language for subscription*: The user can configure the subscription URL to include events in a specific language. Supported languages are English and German.

==== Event Support Requirements
- FR11 *Create lecture series*: Editors and instructors can scaffold a series of lectures by specifying a series end date and one or several initial lectures. The system then generates weekly lectures with default names starting with the initial lectures until the series end date. The user can choose to change the name and dates of single lectures before saving.
- FR12 *Manage planned exercises*: Editors and instructors can create, update and delete planned exercises. They can choose to create single planned exercises or create them in a series. 
- FR13 *Create exercise with planned exercise*: When creating an exercise, instructors and editors can choose a planned exercise to automatically populate dates and title. The system discards the planned exercise after the real exercise is created. 
- FR14 *Inspect events in schedule*: Course staff can choose to inspect either all or only future events of the course through the schedule in chronological order.
- FR15 *Inspect event details in schedule*: Course staff can inspect the details of an event by clicking on it in the schedule.
- FR16 *Filter events in schedule*: Course staff can filter events that are presented in the schedule by event type. To do this a filter component is available that supports filtering by lecture, exercise, tutorial, exam and administrative events.
- FR17 *Manage administrative event*: Through the schedule, course staff members can create an administrative event by specifying its title, start date, and optionally end date, facilitator, participants and a note. They can also update or delete administrative events.

#TODO[
  List and describe all functional requirements of your system. Also mention requirements that you were not able to realize. The short title should be in the form “verb objective”

  - FR1 Short Title: Short Description. 
  - FR2 Short Title: Short Description. 
  - FR3 Short Title: Short Description.
]

=== Quality Attributes<qualityAttributes>
The focus now turns to the quality attributes of the proposed system. Quality attributes define aspects of the system that go beyond its functional behavior and fall into the URPS categories described by Brügge et al. #cite(<Brue2014>). We define the following attributes:

- QA1 *Usability*: The calendar is reachable by using a maximum of three clicks from the course overview, course management and course settings.
- QA2 *Usability*: The schedule is reachable by using a maximum of three clicks from the course overview, course management and course settings.
- QA3 *Usability*: Displaying the iCalendar subscription URL is possible using one click in the calendar component.
- QA4 *Usability*: The calendar should have an adaptive design that supports both big devices such as laptops and small devices such as mobile phones.
- QA5 *Reliability*: The system handles fetching delays of data by displaying a loading indicator if necessary.
- QA6 *Reliability*: The system informs the user about potential errors while fetching data and suggest an action to resolve the error.
- QA7 *Reliability*: The system can handle failing create, update or delete operations by informing the user about the problem and suggesting an action to resolve the error.
- QA8 *Performance*: The system can handle at least 20 iCalendar subscription request per second with a maximum average request delay of 500ms and without causing noticeable delays when using the client.
- QA9 *Performance*: The system can handle at least 10 concurrent event requests per second without noticeable delay in displaying the calendar or schedule.
- QA10 *Supportability*: The system must display the timing of events correctly across multiple timezones.
- QA11 *Supportability*: The system must present dates and texts in a way that is understandable in both English and German speaking locales.
- QA12 *Supportability*: Comprehensive documentation must exist for the system.
- QA14 *Supportability*: The implementation must adhere to Artemis coding guidelines.
#TODO[
  List and describe all quality attributes of your system. All your quality attributes should fall into the URPS categories mentioned in @bruegge2004object. Also mention requirements that you were not able to realize.

  - QA1 Category: Short Description. 
  - QA2 Category: Short Description. 
  - QA3 Category: Short Description.

]

=== Constraints<constraints>
The next section describes the constraints of the time management feature. Constraints also define aspects of the system that are not related to its functional behavior; however, in contrast to quality attributes, they do not fall into the URPS categories #cite(<Brue2014>).

- C1 *Use dayjs*: To avoid unnecessary project size the client uses no other third party libraries than dayjs to process dates since the package is already a project dependency.
- C2 *Use iCalendar standard*: To implement subscriptions the system conforms to the iCalendar standard defined in RFC 5545 #footnote[https://www.rfc-editor.org/rfc/rfc5545.html] to ensure broad compatibility with other calendar applications (e.g., Apple Calendar, Microsoft Outlook Calendar, Google Calendar, Samsung Calendar etc.).
- C3 *Do not encrypt subscription tokens*: To avoid extra configuration overhead for administrators running an Artemis instance, the system stores subscription tokens (see @architecture for context) in plain text in the database. This approach removes the need for administrators to configure an additional encryption key as an environment variable in order to use calendar subscriptions.


#TODO[
  List and describe all pseudo requirements of your system. Also mention requirements that you were not able to realize.

  - C1 Category: Short Description. 
  - C2 Category: Short Description. 
  - C3 Category: Short Description.

]

== System Models<systemModel>
#TODO[
  This section includes important system models for the requirements.
]
The following section explores specific aspects of the proposed system in greater detail through several models. We first illustrate important functionality with two selected demo scenarios. Subsequently, we provide a broader perspective on the system's functionality by identifying its use cases in two use case models. Next, we specify the involved objects through three analysis object models. Finally, we present the calendar's user interface using screenshots taken from the implemented feature.

=== Scenarios
#TODO[
  If you do not distinguish between visionary and demo scenarios, you can remove the two subsubsections below and list all scenarios here.

  *Visionary Scenarios*
  Describe 1-2 visionary scenario here, i.e. a scenario that would perfectly solve your problem, even if it might not be realizable. Use free text description.

  *Demo Scenarios*
  Describe 1-2 demo scenario here, i.e. a scenario that you can implement and demonstrate until the end of your thesis. Use free text description.
]
We now present two demo scenarios to illustrate important functionality of the time management system. A scenario informally describes a single feature, focusing on a specific user interaction with the system. Each scenario represents an instance of a use case that describes functionality on a more general level #cite(<Brue2014>). 

The first scenario shows how a student named Marlon uses the calendar to inspect the details of a lecture event. At the beginning of the semester, Marlon logs into Artemis on his laptop. He has enrolled in the EIST course and wants to know when and where the first lecture takes place. Marlon navigates to the course's calendar and spots in the month presentation that the first lecture is scheduled for next week. He switches to the week presentation and navigates to the week of the lecture. Even before clicking on the event, he can see from its position in the grid that the lecture takes place on Monday from 13:00 to 14:30. When he clicks on the event, the calendar displays a detail view revealing the room number of the lecture hall as the event's location. 

The second scenario illustrates how the instructor, Stephan, creates a lecture series. Before the semester begins, Stephan prepares the lectures for the EIST course he will teach. He logs into Artemis and navigates to the course management's lecture page. There, he clicks "Create Lecture" and selects the option to create a lecture series. He chooses the date on which the series should end and specifies the start and end dates for the first two lectures — one on the following Monday and one on the following Wednesday. Artemis then generates the lecture series by repeating these two lectures weekly and displays the result to Stephan. He removes the Wednesday lecture in the third week, knowing that it falls on a public holiday. Since he already has a title for the first lecture, he replaces the default "Lecture 1" with the actual name. After reviewing the setup, Stephan clicks "Save". Artemis redirects him to the course management's lecture page, where he confirms that the system generated all lectures correctly.

=== Use Case Model
#TODO[
  This subsection should contain a UML Use Case Diagram including roles and their use cases. You can use colors to indicate priorities. Think about splitting the diagram into multiple ones if you have more than 10 use cases. *Important:* Make sure to describe the most important use cases using the use case table template (./tex/use-case-table.tex). Also describe the rationale of the use case model, i.e. why you modeled it like you show it in the diagram.
]
We now move on to analyze the use cases of the time management feature. The use cases of a system provide a comprehensive description of all functionality. Each use case represents a generalization over a set of possible scenarios #cite(<Brue2014>). In each of the two subsections of this chapter, we provide an overview of the use cases of a separate part of the time management feature by presenting a use case model. Additionally, we develop two selected use cases in semiformal form, as proposed by Brügge et al #cite(<Brue2014>).

==== Calendar Use Cases
@calendarUseCaseDiagram shows the use cases related to the calendar. When visiting the calendar, the user can _*inspect events*_. Several scenarios arise from this use case, since users can choose between different calendar presentations for inspecting events. 

Two use cases can optionally extend the *_inspect events_* use case: users can _*filter events*_ by interacting with a filter component in the calendar. They can toggle various filter options to create different configurations, each representing a distinct scenario. The _*navigate in time*_ use case can also extend the _*inspect events*_ use case. Depending on the scenario, users navigate backwards or forwards in time to reveal a specific event.

Furthermore, users can _*inspect event details*_. This use case covers the scenarios of clicking on any event that the calendar contains. It always includes the _*inspect events*_ use case, since users must first locate an event in the calendar and then click on it to reveal its details.

#figure(
      image(
        "../figures/CalendarUseCaseDiagram.png", width: 90%,
      ),
      caption: [Functional model for the calendar (UML use case diagram)],
)<calendarUseCaseDiagram>

Moving on, users can invoke the _*create subscription*_ use case. For this, they configure which event types to include and which language to use, each configuration representing a distinct scenario.

In @inspectEventDetailsUseCase, we now semi-formally describe the _*inspect event details*_ use case in a use case table as proposed by Brügge et al #cite(<Brue2014>).

#v(1em)
#figure(caption: [Use case describing how a user inspects the details of an event in the calendar])[
  #let flowOfEvents = [
    + The user invokes the _*inspect events*_ use case by navigating to the calendar tab of the course overview and choosing one of the available calendar presentations to inspect available events.
    + Optionally, he invokes the _*filter events*_ use case by selecting or un-selecting filter options to show or hide specific event types.
    + Optionally, he invokes the _*navigate in time*_ use case to navigate to the event of which he would like to display details.
    + The user then clicks on the event and inspects the details.
  ]
  #text(size: 8pt)[
    #table(
      columns: (1fr, 3fr),
      stroke: (x: none),
      align: (top + left, top + left),
      inset: (y: 0.8em, x: 0.5em),
      [Use case name], [Inspect event details],
      [Participating actors], [User],
      [Flow of events], flowOfEvents,
      [Entry conditions], [The user is logged into Artemis.],
      [Exit conditions], [The user inspected the events details.],
      [Quality attributes], [QA1, QA4, QA5, QA6, QA9, QA10, QA11],
    )
  ]
]<inspectEventDetailsUseCase>
#v(1em)

==== Event Support Use Cases
In @eventSupportUseCaseDiagram, we present the use cases that support the display of lecture, exercise, and administrative events in the calendar. Instructors and editors can *create lecture series*. Different scenarios arise for this use case, as there are numerous ways to configure a lecture series.

Furthermore, instructors and editors can *manage planned exercises*. Managing a planned exercise summarizes the scenarios of creating, updating, or deleting a planned exercise. Finally, instructors and editors can *create exercises with a planned exercise* by selecting a planned event in the creation page and thereby automatically populating the title and date properties of the new exercise.

Since the calendar and the schedule represent two different perspectives on the same events, several use cases overlap: Course staff members can _*inspect events in the schedule*_, which is a list that orders events chronologically. While inspecting events, they can choose to view either all events or only future ones, resulting in two different scenarios. As with the calendar, course staff can extend the _*inspect events in schedule*_ use case with the _*filter events in schedule*_ use case by including or excluding specific event types in the filter component. Also, _*inspect event details in schedule*_ again includes the _*inspect events in schedule*_ use case as the user has to browse existing events in the schedule and click on a specific entry to reveal its details.

#figure(
      image(
        "../figures/EventSupportUseCaseDiagram.png",
      ),
      caption: [Functional model for supporting lecture, exercise and administrative events (UML use case diagram)],
)<eventSupportUseCaseDiagram>

Finally, course staff members can _*manage administrative events*_. Depending on the scenario, this means creating, updating, or deleting an administrative event in the schedule. Managing an administrative event always includes the _*inspect events in schedule*_ use case as the user needs to locate the event on which he would like to perform the operation.

In @manageCustomEventUseCase, it follows a semiformal description of the _*manage administrative event*_ use case.

#figure(caption: [Use case describing how a user manages administrative events in the schedule])[
  #let flowOfEvents = [
    + The course staff member invokes the _*inspect events in schedule*_ use case by navigating to the dashboard tab of the course management and scrolling down to the schedule.
    + Optionally, he invokes the _*filter events in schedule*_ use case by selecting or un-selecting filter options to show or hide specific event types.
    + Here he can perform several operations on administrative events:
      - To create an event, he presses a button in the schedule, specifies a title and start date, and optionally adds an end date, location, facilitator, note, and participants. He completes the operation by saving or aborts it. 
      - To update an event, he presses a button in the event’s list entry and modifies the same properties as in the create operation. He saves the changes or cancels.
      - To delete an event, he presses a button in the event’s list entry. The system then asks him to confirm or cancel the operation.
    + Finally, the course staff member verifies the result of the performed operation in the schedule. 
    
  ]
  #text(size: 9pt)[
    #table(
      columns: (1fr, 3fr),
      stroke: (x: none),
      align: (top + left, top + left),
      inset: (y: 0.8em, x: 0.5em),
      [Use case name], [Manage administrative event],
      [Participating actors], [Course staff member],
      [Flow of events], flowOfEvents,
      [Entry conditions], [The user is logged into Artemis.],
      [Exit conditions], [The user sees the result of the operation he performed in the schedule.],
      [Quality attributes], [QA2, QA5, QA6, QA7, QA9, QA10, QA11],
    )
  ]
]<manageCustomEventUseCase>
#v(1em)

#pagebreak()

=== Analysis Object Model<AnalysisObjectModels>
#TODO[ 
  This subsection should contain a UML Class Diagram showing the most important objects, attributes, methods and relations of your application domain including taxonomies using specification inheritance (see @bruegge2004object). Do not insert objects, attributes or methods of the solution domain. *Important:* Make sure to describe the analysis object model thoroughly in the text so that readers are able to understand the diagram. Also write about the rationale how and why you modeled the concepts like this.

]
The next section specifies the objects related to the proposed system. We use three analysis object models for this and explain them in the following paragraphs. By defining the important objects and their relationships, we ensure clear terminology and avoid ambiguity #cite(<Brue2014>). The section has three parts: the first focuses on the calendar, the second on objects related to planning exercises and scaffolding lectures, and the third addresses the schedule.

==== Calendar Objects
@calendarAnalysisObjectModel shows calendar-related objects. A *User* can be enrolled in multiple *Courses*. Each course has exactly one *Calendar* that the user can *visit* through the course's *overview*. A calendar offers multiple *presentations* to display events. For instance, the calendar for large devices includes both month and week presentations, while the calendar for small devices includes month and day presentations.

#figure(
      image(
        "../figures/CalendarAnalysisObjectModel.svg",
      ),
      caption: [Analysis object model for the calendar (UML class diagram)],
)<calendarAnalysisObjectModel>

Because a calendar displays *Events* in its presentations, each calendar is related to multiple events. Every event includes at least a *title* and a *start date*. Optionally, an event may also include an *end date*, a *location*, and a *facilitator*. When visiting the calendar, the user can *inspect events and their details* or *filter* events as needed.

The user can also *create* and *revoke* *Subscriptions* that are related to a specific calendar. Both users and calendars can be associated with multiple subscriptions. For each subscription, the user defines *filter options* that select which events from the calendar to include and a *language option* that specifies the language of the events' properties.

==== Plan Exercises and Scaffold Lectures

@planAndScaffoldAnalysisObjectModel presents the objects connected to the measures we take to address the problem that events from lectures and exercises only become available after their creation. To solve this, we extend the functionality of the  *Course*'s *management*. 

Specific *Users* — namely instructors and editors — can *create* a *Lecture Series* through the course management interface. The creator defines an *initialStartDate* and *initialEndDate* for one or more initial lectures. Each planned lecture series, therefore, contains one or multiple of these dates. The user must also set a *seriesEndDate*. Starting from the initial lectures, the system generates weekly lectures up to the specified series end, assigns default *titles*, and sets their *startDate* and *endDate* accordingly. The user can then *adjust* individual lectures in the series by modifying any of their properties.

Similarly, instructors and editors can *create* a *Planned Exercise Series* through course *management*. They define *initialReleaseDate*, *initialStartDate*, *initialDueDate*, and *initialAssessmentDueDate* for one or more initial exercises, along with a *seriesEndDate*. The system then generates weekly planned exercises up to the series end, assigns default titles, and sets *releaseDate*, *startDate*, *dueDate*, and *assessmentDueDate* accordingly. Before finalizing, users can *adjust* individual exercises by changing their titles or dates. After creation, they can *inspect*, *update*, *delete* planned exercises and also *create* single ones. Each planned exercise is intended to correspond to an actual *Exercise*, allowing users to automatically populate date properties when creating real exercises.

#figure(
      image(
        "../figures/PlanAndScaffoldAnalysisObjectModel.svg",
      ),
      caption: [Analysis object model for planning exercises/scaffolding lectures (UML class diagram)],
)<planAndScaffoldAnalysisObjectModel>

==== Schedule Objects
@scheduleAnalysisObjectModel displays objects related to the schedule. As explained earlier, each *User* can be associated with multiple *Courses*. Artemis supports four user types: *Students*, Tutors, editors, and instructors. For the purposes of this thesis, we group the last three as *Course Staff Members*. 

Similar to the calendar, each course provides exactly one *Schedule*. Course staff members can *visit* this schedule through the course's *management*. The schedule displays events chronologically in one of two *presentations*: a list of all events or a list of future events. When visiting the schedule, the user can, as with the calendar, *inspect events and their details* as well as *filter* events.

The schedule contains two types of events: The first event subtype is the family of *Derived Events*. These events originate from existing Artemis objects that have date properties. Derived events include lecture events derived from lectures, tutorial events derived from tutorial group sessions, exercise events derived from exercises and planned exercises, and exam events derived from exams. 

The second event subtype consists of *Administrative Events*. They appear only to course staff members in both the schedule and the calendar and support the coordination of administrative tasks. Course staff members can actively *create*, *update*, and *delete* instances of this type, in contrast to derived events, which the system automatically generates. The schedule displays the same event properties as the calendar (*title*, *startDate*, and optionally *endDate*, *facilitator*, and *location*). However, only for administrative events, course staff members can additionally specify *participants* and a *note*.

#figure(
      image(
        "../figures/ScheduleAnalysisObjectModel.svg",
      ),
      caption: [Analysis object model for the schedule (UML class diagram)],
)<scheduleAnalysisObjectModel>

=== User Interface
#TODO[
  Show mockups of the user interface of the software you develop and their connections / transitions. You can also create a storyboard. *Important:* Describe the mockups and their rationale in the text.
]
We continue with a presentation of the calendar's user interface. First, we show the interface on larger devices such as laptops. Then, we turn to smaller devices, such as mobile phones. For both variants, we present the overview and detail presentation, as well as the subscription and filter components.

@desktopMonthDemo shows the month view of the calendar on a laptop. This view provides a high-level overview of how events are distributed across a selected month. It displays a grid of days for that month, with the current day highlighted by a blue date badge.

#figure(
      image(
        "../figures/UI/DesktopMonth.png",
      ),
      caption: [Month presentation displayed on a laptop],
)<desktopMonthDemo>

Each cell in the grid lists the events scheduled for that day. If more than three events occur, the calendar displays the first two and adds a label indicating the number of additional events that are hidden. We can see an example of this on September 30th in @desktopMonthDemo. Events are color-coded by type, and clicking on an event opens a popover with its details.

Navigation controls sit above the grid: chevron buttons in the top-right corner let users move to the next or previous month, while the "Today" button on the left jumps directly to the current month. In the top-left corner, the calendar displays the currently selected month and year.

The controls section above the grid also includes a presentation switch, which lets the user toggle from the month presentation to the week presentation shown in @desktopWeekDemo. This view provides a more detailed perspective, showing a scrollable grid with seven columns, each representing a day of the selected week. The current day is again highlighted with a blue date badge instead of a gray one.

#figure(
      image(
        "../figures/UI/DesktopWeek.png",
      ),
      caption: [Week presentation displayed on a laptop],
)<desktopWeekDemo>

The week view allows the user to quickly see the timing of events across the week. Overlapping events appear stacked horizontally within a column. As in the month view, events are color-coded by type and can be clicked to open a detail popover. The presentation also provides the same navigation controls, with the only difference being that the today button jumps to the current week. If a week spans two months, the presentation title in the top-left corner reflects this.

The user can filter events in both presentations using the filter component shown in @desktopFilterDemo. Selected event types appear as chips, each featuring a close button, a label, and a colored box that corresponds to the type's color coding. The user can remove event types by clicking a chip’s close button or expand the component to select or deselect specific types.

#grid(
  columns: (4fr, 4fr),
  gutter: 10pt,
  [
    #figure(
      placement: none,
      image(
        "../figures/UI/DesktopFilter.png"
      ),
      caption: [Expanded filter component displayed on a laptop],
    )<desktopFilterDemo>
  ],
  [
    #figure(
      placement: none,
      image(
        "../figures/UI/DesktopSubscriptionPopover.png"
      ),
      caption: [Expanded popover for creating iCalendar subscriptions on a laptop],
    )<desktopSubsciptionPopoverDemo>
  ],
)

To configure an iCalendar subscription, the user clicks the subscribe button in either presentation to open a popover. Inside, he can choose the language used to generate the event texts and decide whether to include lecture, exercise, tutorial, or exam events. Based on these inputs, the system generates a subscription URL. The user can copy this URL either by selecting the text or by clicking the copy button next to it. He can then paste the link into the settings of any external calendar application to subscribe it to the Artemis calendar.

#grid(
  columns: 2,
  gutter: 10pt,
  [
    #figure(
      placement: none,
      image(
        "../figures/UI/MobileMonth.png"
      ),
      caption: [Month presentation displayed on a mobile phone],
    )<mobileMonthDemo>
  ],
  [
    #figure(
      placement: none,
      image(
        "../figures/UI/MobileDay.png"
      ),
      caption: [Day presentation displayed on a mobile phone],
    )<mobileDayDemo>
  ],
)

@mobileMonthDemo and @mobileDayDemo illustrate the overview and detail views for small devices. They provide the same functionality as the desktop views but with a simplified interface to conserve space. The month view again displays a grid of the selected month, with the month and year displayed in the header. Unlike the desktop version, events appear as small capsules without titles. If a day contains more than three events, the calendar shows two capsules followed by three dots (as on September 30 in the example). Navigation controls — previous, next, and today — sit above the grid. Unlike on desktop, the user can not open event details directly in the month view; For that, switching to the day view is required.

Instead of using a toggle to switch between views, clicking a specific day in the month grid opens the day presentation. This action collapses most of the month grid, leaving only the week of the selected day attached to the header. Below, the calendar displays the day presentation, which mirrors the week view but reduces it to a single column representing the chosen day instead of seven. Within the week section, the selected day appears in a slightly darker shade, while the current day’s date badge colors its number blue. The user can go back to the month presentation by clicking the cross button in the upper left corner of the grid.

#grid(
  columns: 2,
  gutter: 10pt,
  [
    #figure(
      placement: none,
      image(
        "../figures/UI/MobileFilter.png"
      ),
      caption: [Expanded filter component displayed on a mobile phone],
    )<mobileFilterDemo>
  ],
  [
    #figure(
      placement: none,
      image(
        "../figures/UI/MobileSubscription.png"
      ),
      caption: [Expanded popover for creating iCalendar subscriptions on a mobile phone],
    )<mobileSubsciptionPopoverDemo>
  ],
)

To save space on small screens, the filter and subscription controls use compact buttons with symbolic icons that open popovers. As @mobileFilterDemo shows, the filter popover provides checkboxes to select or deselect event categories. In @mobileSubsciptionPopoverDemo, we see that the subscription popover includes the same options as on larger devices but arranges them in a vertical layout for better readability.

#pagebreak()