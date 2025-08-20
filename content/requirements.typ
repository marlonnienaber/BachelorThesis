#import "/utils/todo.typ": TODO

= Requirements<requirements>
#TODO[
  This chapter follows the Requirements Analysis Document Template in @bruegge2004object. Important: Make sure that the whole chapter is independent of the chosen technology and development platform. The idea is that you illustrate concepts, taxonomies and relationships of the application domain independent of the solution domain! Cite @bruegge2004object several times in this chapter.

]

== Overview
#TODO[
  Provide a short overview about the purpose, scope, objectives and success criteria of the system that you like to develop.
]

== Existing System<existingSystem>
Artemis courses do not provide a feature that support time management. Instead, managing tasks in the context of a course often requires users to log in and navigate to a specific component of the course page to check an associated date. Students have to navigate to exercise pages to check respective working times, and visit lecture and exam pages to inform themselves for lecture and exam dates. 

Sometimes users even have to use external tools because course related material is not yet released and the according date is therefore not yet available on Artemis or because Artemis does currently provide no feature that informs about the date of interest at all. A good example for this would be course staff meetings. Since there is no centralized location where all important events are listed, time management with Artemis can be cumbersome and inefficient at times.
#TODO[
  This section is only required if the proposed system (i.e. the system that you develop in the thesis) should replace an existing system.
]

== Proposed System
To address this problem I propose to integrate a calendar feature into the course page. Here users can inspect all events that are relevant to them in the context of the given course. The events can be categorized into two groups based on which subset of users can access them:

Firstly, there will be coursewide events. Course staff can create this type of event through a dedicated coursewide event management page that will be integrated into the course management page. In doing so, the creator can can choose to grant or restrict access to the event for each user group of the course.

Secondly, the calendar includes tutorial events that are directly derived from tutorial group session. Those events are exclusively visible to users that are either students or tutor of the tutorial group related to the session. As mentioned in @existingSystem, Artemis already provides a component for managing tutorial group session schedules.

Through both coursewide event management and tutorial group session management, a comprehensive course schedule can be created. The calendar displaying this schedule provides users with exactly the information that they require to execute the tasks related to their roles, while hiding irrelevant events.

=== Functional Requirements
The following section analyzes the functionality of the proposed system, quality attributes that it should cater to and constraints that it must respect.

*Functional Requirements for Calendar*
- FR1 *Inspect tutorial events*: Both tutors and students can inspect the tutorial events of their tutorial groups in the calendar.
- FR2 *Inspect coursewide events*: All user groups of a given course can inspect the course's coursewide events in the calendar.
- FR3 *Inspect event details*: Users can click on each event and inspect course details (title, start date and optionally end date, location and facilitator if given for event) in a popover
- FR4 *Support smaller devices*: On smaller devices the calendar displays event through a component that is optimized for smaller screen sizes such as those of mobile devices.
- FR5 *Support bigger devices*: On bigger devices the calendar displays event through a component that is optimized for bigger screen sizes such as those of desktop computers, laptops and tablets.
- FR6 *Navigate to today*: The user can always press a button that causes the calendar to include the current day in its current presentation.
- FR7 *Filter events*: Users can select and exclude courses for which the coursewide and tutorial events are displayed in the calendar.
- FR8 *Subscribe local calendar*: Users can copy an ICS subscription link to subscribe their local calendars to the Artemis calendar.
- FR9 *Configure subscription*: Users can configure their ICS subscription before copying the link to include or exclude both tutorial events and coursewide events for each of their courses.

*Functional Requirements for Coursewide Event Management*
- FR10 *View coursewide events*: Course staff can inspect the coursewide events of the given course if the event is flagged as visible to their respective user group.
- FR11 *View arbitrary coursewide events as instructor*: Instructors have the option to view all coursewide calendar events of a respective course regardless of whether the event is flagged as visible to instructors.
- FR12 *Create coursewide events*: Course staff can create coursewide events by specifying a title, start date and whether the event should be visible to students, tutors, editors or instructors respectively (by default the event must be visible to the user group of the creator). The creator can optionally add an end date, location and facilitator.
- FR13 *Limit visibility options for tutors*: Tutors are not allowed to make events visible to students or change the visibility flag for students on existing events. This prevents tutors from publishing/removing events that students interpret as official course information.
- FR14 *Create coursewide event series*: When creating an event course staff can optionally determine a daily, weekly or monthly repetition frequency and a repetition end date to create a series of coursewide events.
- FR15: *Confirm visibility settings*: Course staff must confirm the selected visibility settings when creating a coursewide event in a confirmation dialogue. This avoids accidentally making the event visible to an unwanted user group and thereby making their schedule disorganized or leaking confidential information for course staff to students.
- FR16 *Update coursewide events*: Course staff can update the title, start date, end date, location, facilitator and visibility settings for coursewide events that are visible to them. Tutors can not make events visible to students.
- FR17 *Update all coursewide events as instructor*: Instructors can update all coursewide calendar events of the course when the option to view all events is enabled.
- FR18 *Delete coursewide events*: Course staff can delete coursewide events that are visible to them.
- FR19 *Delete arbitrary coursewide events as instructor*: When the option to view all events is enabled instructors can also delete coursewide events that are not flagged as visible to instructors.
- FR20 *Confirm deletion*: Course staff must confirm the operation in a confirmation dialogue when deleting coursewide events.

#TODO[
  List and describe all functional requirements of your system. Also mention requirements that you were not able to realize. The short title should be in the form “verb objective”

  - FR1 Short Title: Short Description. 
  - FR2 Short Title: Short Description. 
  - FR3 Short Title: Short Description.
]

=== Quality Attributes

- QA1 *Usability*: The calendar is reachable using a maximum of three clicks from course overview, course management and course settings.
- QA2 *Usability*: Displaying the ICS subscription link is possible using one click in the calendar component.
- QA3 *Usability*: The coursewide event management should be reachable within a maximum of 3 clicks from course overview, course management and settings.
- QA4 *Reliability*: The calendar handles fetching delays of events by displaying a loading indicator if necessary.
- QA5 *Reliability*: The calendar informs the user about potential errors while fetching events and suggest an action to resolve the error.
- QA6 *Reliability*: The coursewide event management can handle failing CRUD operations by informing the user of the problem.
- QA7 *Performance*: The server can support at least 2000 clients calling the ICS subscription endpoint one time per minute each without causing noticeable delays when using the client.
- QA8 *Performance*: The client can handle 1 fetch per second without displaying the loading indicator with an medium quality internet connection (80 Mbps) and a server that serves 1 client at a time.
- QA9 *Supportability*: The calendar must display events correctly across multiple timezones.
- QA10 *Supportability*: The calendar must present dates, labels and texts in a way that is understandable in both english and german speaking locales.
#TODO[
  List and describe all quality attributes of your system. All your quality attributes should fall into the URPS categories mentioned in @bruegge2004object. Also mention requirements that you were not able to realize.

  - QA1 Category: Short Description. 
  - QA2 Category: Short Description. 
  - QA3 Category: Short Description.

]

=== Constraints
- C1 *Use dayjs*: To avoid unnecessary project size the client uses no other third party libraries than dayjs to process dates since the package is already a project dependency.
- C2 *Use ICS format*: The calendar uses the ICS format for its subscription endpoint to endure broad compatibility with other calendar applications (e.g., Apple Calendar, Microsoft Outlook Calendar, Google Calendar, etc.).

#TODO[
  List and describe all pseudo requirements of your system. Also mention requirements that you were not able to realize.

  - C1 Category: Short Description. 
  - C2 Category: Short Description. 
  - C3 Category: Short Description.

]

== System Models
#TODO[
  This section includes important system models for the requirements.
]

=== Scenarios
#TODO[
  If you do not distinguish between visionary and demo scenarios, you can remove the two subsubsections below and list all scenarios here.

  *Visionary Scenarios*
  Describe 1-2 visionary scenario here, i.e. a scenario that would perfectly solve your problem, even if it might not be realizable. Use free text description.

  *Demo Scenarios*
  Describe 1-2 demo scenario here, i.e. a scenario that you can implement and demonstrate until the end of your thesis. Use free text description.
]

=== Use Case Model
#TODO[
  This subsection should contain a UML Use Case Diagram including roles and their use cases. You can use colors to indicate priorities. Think about splitting the diagram into multiple ones if you have more than 10 use cases. *Important:* Make sure to describe the most important use cases using the use case table template (./tex/use-case-table.tex). Also describe the rationale of the use case model, i.e. why you modeled it like you show it in the diagram.

]

=== Analysis Object Model
#TODO[
  This subsection should contain a UML Class Diagram showing the most important objects, attributes, methods and relations of your application domain including taxonomies using specification inheritance (see @bruegge2004object). Do not insert objects, attributes or methods of the solution domain. *Important:* Make sure to describe the analysis object model thoroughly in the text so that readers are able to understand the diagram. Also write about the rationale how and why you modeled the concepts like this.

]

=== Dynamic Model
#TODO[
  This subsection should contain dynamic UML diagrams. These can be a UML state diagrams, UML communication diagrams or UML activity diagrams.*Important:* Make sure to describe the diagram and its rationale in the text. *Do not use UML sequence diagrams.*
]

=== User Interface
#TODO[
  Show mockups of the user interface of the software you develop and their connections / transitions. You can also create a storyboard. *Important:* Describe the mockups and their rationale in the text.
]