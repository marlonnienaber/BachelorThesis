#import "/utils/todo.typ": TODO 
#import "../utils/icons.typ": check, cross

= Summary<summary>
#TODO[
  This chapter includes the status of your thesis, a conclusion and an outlook about future work.
]
The following final chapter summarizes the work done as part of this thesis. It starts by presenting the status of the functional requirements, distinguishing between realized and open goals. It then describes the realized goals in more detail, highlighting the functionality that we successfully implemented. After that, attention turns to the open goals, explaining the requirements that we could not yet address and the reasons behind these gaps. Finally, the thesis concludes by reflecting on the contributions of this work and outlining opportunities for future development.

== Status
#TODO[
  Describe honestly the achieved goals (e.g. the well implemented and tested use cases) and the open goals here. if you only have achieved goals, you did something wrong in your analysis.
]
The following table revisits the functional requirements defined in @requirements and evaluates their implementation status. It marks realized requirements with #check and open ones with #cross.

#figure(
  caption: [Status of the calendar requirements],
  table(
    columns: (1fr, auto),
    align: (left, center),
    [*Functional Requirement*], [*Status*],
    [FR1 Inspect events in overview], [#check],
    [FR2 Inspect events in detail view], [#check],
    [FR3 Inspect event details], [#check],
    [FR4 Navigate backwards in time], [#check],
    [FR5 Navigate forward in time], [#check],
    [FR6 Navigate to today], [#check],
    [FR7 Filter events], [#check],
    [FR8 Copy subscription link], [#check],
    [FR9 Configure events for subscription], [#check],
    [FR10 Configure language for subscription], [#check],
  )
)

#figure(
  caption: [Status of event support requirements ],
  table(
    columns: (1fr, auto),
    align: (left, center),
    [*Functional Requirement*], [*Status*],
    [FR11 Create Lecture series], [#check],
    [FR12 Mange Planned Exercises], [#cross],
    [FR13 Create Exercise with Planned Exercise], [#cross],
    [FR14 Inspect events in schedule], [#cross],
    [FR15 Inspect event details in schedule], [#cross],
    [FR16 Filter events in schedule], [#cross],
    [FR17 Manage administrative event], [#cross],
  )
)



=== Realized Goals
#TODO[
  Summarize the achieved goals by repeating the realized requirements or use cases stating how you realized them.
]
We implemented the overview (FR1) and detail views (FR2) of the calendar for both large devices, such as laptops, and small devices, such as smartphones. Specifically, large devices support a month presentation and a week presentation, while small devices support a month presentation and a day presentation. Users can inspect the details of an event in the month view on large devices, as well as in the week and day views (FR3).

All presentations provide controls to navigate backward (FR4) and forward (FR5) in time, and to jump directly to today (FR6). A filter component is available across the calendar, allowing users to filter events by type (FR7). In every presentation, users can also open a popover to configure subscriptions by selecting which events to include (FR8) and which language to use (FR9), and then copy the subscription URL (FR10).

To enable the early display of lecture-related events without requiring the creation of full lecture instances, editors and instructors can create lecture series (FR11) by specifying only temporal data. 

=== Open Goals
#TODO[
  Summarize the open goals by repeating the open requirements or use cases and explaining why you were not able to achieve them. Important: It might be suspicious, if you do not have open goals. This usually indicates that you did not thoroughly analyze your problems.
]
Instructors and editors should have been able to manage planned exercises (FR12) to make the early display of exercise-related events possible. They also should have been able to use planned exercises to create actual exercises (FR13). We implemented a prototype towards the end of this thesis to explore a possible solution for this functionality.

During evaluation of the prototype, it became clear that the current approach could not provide the necessary flexibility to ensure adoption by a variety of users while keeping complexity low enough to ensure adoption. The requirements for this functionality require further refinement. We therefore postponed the implementation in favor of conceptualizing future improvements, such as event merging and detail page linking (see Future Work).

An additional plan involved integrating a schedule component into the course management to provide the teaching team with a shared mental model of the course’s structure. The schedule should have listed course events in chronological order and supported the management of Administrative Events (FR17) to simplify organizational tasks. Course staff should have been able to display all or only upcoming events (FR14), filter events (FR16), and inspect event details (FR15) by selecting individual entries.

We assigned lower priority to these requirements because they primarily concern course staff. The focus shifted instead towards student-facing functionality. Due to time constraints, we were ultimately unable to realize the schedule requirements.

== Conclusion
#TODO[
  Recap shortly which problem you solved in your thesis and discuss your *contributions* here.
]
This thesis aimed to extend Artemis with a feature that supports users' personal time management. To achieve this, @introduction defined four goals: supporting derived events in the calendar, enabling lecture scaffolding and exercise planning, providing a subscription mechanism, and supporting the management of administrative events through the schedule.

By the end of this thesis, we realized goal 1, parts of goal 2, and goal 3. The calendar allows students and course staff to quickly view the most important course events. Lecture scaffolding ensures early availability of lecture events, supporting better planning. Configurable iCalendar subscriptions empower users to integrate Artemis events into their personal devices' calendars.

== Future Work
#TODO[
  Tell us the next steps (that you would do if you have more time). Be creative, visionary and open-minded here.
]
Several opportunities for work beyond the scope of this thesis remain. The following ideas outline potential future directions, starting with an expansion of the calendar’s event types. Administrative events, though not prioritized during this thesis, could still offer valuable support for course staff.

Besides this, caching strategies represent another direction for improvement. This thesis deliberately deferred the implementation of caching for the iCalendar endpoint. Future development should include monitoring the system under realistic load conditions and, if necessary, introducing caching mechanisms. The Spring Boot caching API, together with the existing Hazelcast provider, offers a straightforward path toward efficient performance optimization.

Finally, some opportunities exist to enhance the user experience of the calendar. A concrete example concerns the week and day presentations, which allow scrolling but sometimes conceal events. Users may struggle to discover these hidden entries without additional guidance. A small indicator at the top or bottom of columns containing hidden events would ensure visibility and prevent accidental oversights. 

In the month presentations, each day displays a stack of calendar events. Specifically, events of the same type often occur on the same date — for example, multiple exercises in a week might share the same due date. Merging such events into a single entry would enhance readability. Adding links to the corresponding entity detail pages in the event detail popover (e.g., linking exercise events to their exercise detail pages) would further improve usability.

