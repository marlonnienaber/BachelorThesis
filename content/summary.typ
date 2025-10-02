#import "/utils/todo.typ": TODO

= Summary<summary>
#TODO[
  This chapter includes the status of your thesis, a conclusion and an outlook about future work.
]
The following final chapter summarizes the work done as part of this thesis. We first present the status of the functional requirements, distinguishing between realized and open goals. We then describe the realized goals in more detail, highlighting the functionality that we successfully implemented. After that, we turn to the open goals, explaining the requirements that we could not yet address and the reasons behind these gaps. Finally, we conclude the thesis by reflecting on the contributions of the work and outlining opportunities for future research and development.

== Status
#let realized = emoji.checkmark.box
#let inProgress = emoji.hammer
#let open = emoji.crossmark
#TODO[
  Describe honestly the achieved goals (e.g. the well implemented and tested use cases) and the open goals here. if you only have achieved goals, you did something wrong in your analysis.
]
In the following tables we recapitulate on the functional requirements defined in @requirements and evaluate their implementation status. We mark realized requirements with #realized and open ones with #open.


#figure(
  caption: [Status of the calendar requirements],
  table(
    columns: (1fr, auto),
    align: (left, center),
    [*Functional Requirement*], [*Status*],
    [FR1 Inspect events in month presentation on big devices], [#realized],
    [FR2 Inspect events in month presentation on small devices], [#realized],
    [FR3 Inspect events in week presentation on big devices], [#realized],
    [FR4 Inspect events in day presentation on small devices], [#realized],
    [FR5 Inspect event details], [#realized],
    [FR6 Navigate backwards in time], [#realized],
    [FR7 Navigate forward in time], [#realized],
    [FR8 Navigate to today], [#realized],
    [FR9 Filter events], [#realized],
    [FR10 Copy subscription link], [#realized],
    [FR11 Configure events for subscription], [#realized],
    [FR12 Configure language for subscription], [#realized],
  )
)

#figure(
  caption: [Status of the scaffold lecture and plan exercises requirements],
  table(
    columns: (1fr, auto),
    align: (left, center),
    [*Functional Requirement*], [*Status*],
    [FR13 Create Lecture series], [#realized],
    [FR14 Create Planned Exercise series], [#realized],
    [FR15 Inspect Planned Exercises], [#realized],
    [FR16 Manage Planned Exercises], [#realized],
    [FR17 Create Exercise with Planned Exercise], [#realized],
  )
)

#figure(
  caption: [Status od the schedule requirements],
  table(
    columns: (1fr, auto),
    align: (left, center),
    [*Functional Requirement*], [*Status*],
    [FR18 Inspect all or future events], [#open],
    [FR19 Inspect event details], [#open],
    [FR20 Filter events], [#open],
    [FR21 Manage administrative event], [#open],
  )
)


=== Realized Goals
#TODO[
  Summarize the achieved goals by repeating the realized requirements or use cases stating how you realized them.
]
We implemented the calendar for both large devices such as laptops and small devices such as smartphones. This includes high-level overviews as well as detailed views on both platforms. Specifically, large devices support the month view (FR1) and the week view (FR3), while small devices support the month view (FR2) and the day view (FR4). As planned, users can inspect the details of an event in the month view on large devices, as well as in the week and day views (FR5).

All presentations provide controls to navigate backward (FR6) and forward (FR7) in time, and to jump directly to today (FR8). A filter component is available across the calendar that allows users to filter events by type (FR9). In every presentation, users can also open a popover to configure subscriptions by selecting which events to include (FR11) and which language to use (FR12), and then copy the subscription URL (FR10).

We also enabled the early display of lecture- and exercise-related events without requiring the creation of full lecture or exercise instances. Editors and instructors can create lecture series (FR13) by specifying only temporal data, and similarly create series of Planned Exercises (FR14). They can also inspect (FR15) and manage (FR16) Planned Exercises in a list view. A Planned Exercise serves as a proxy for a real Exercise. When creating an Exercise, the creator can select a Planned Event to automatically fills in date properties (FR17). 

=== Open Goals
#TODO[
  Summarize the open goals by repeating the open requirements or use cases and explaining why you were not able to achieve them. Important: It might be suspicious, if you do not have open goals. This usually indicates that you did not thoroughly analyze your problems.
]
We initially planned to integrate a schedule component into the course management to serve as a shared mental model for the teaching team of the course's outline. The schedule would have listed course events in a chronological list view and supported managing Administrative Events (FR21) to facilitate organizational matters. Course staff could have chosen to display either all events or only future events (FR18). They would also have had the ability to filter events (FR19) and inspect details of individual events (FR20) by clicking on them.

We assigned lower priority to these requirements because they primarily concern course staff. We focused instead on requirements that describe student-facing functionality, which we considered more important. Due to time constraints, we eventually were not able to realize the schedule requirements.

== Conclusion
#TODO[
  Recap shortly which problem you solved in your thesis and discuss your *contributions* here.
]
This thesis aimed to extend Artemis with a feature that supports users’ personal time management. To achieve this, we defined four goals in @introduction: supporting Derived Events in the calendar, enabling lecture scaffolding and exercise planning, providing a subscription mechanism, and supporting the management of Administrative Events through the schedule.

By realizing the first three goals, we enabled students and course staff to quickly gain an overview of the most important course events in the calendar. With the introduction of lecture scaffolding and exercise planning we ensured that regularly occurring events become available early in the semester so that users can plan with them. Finally, we empowered users to integrate Artemis events into their personal device calendars by implementing configurable iCalendar subscriptions.


== Future Work
#TODO[
  Tell us the next steps (that you would do if you have more time). Be creative, visionary and open-minded here.
]
Several opportunities for work beyond the scope of this thesis remain. We present some ideas for future work, beginning with an expansion of the calendar’s event types. The events currently supported already facilitate time management for many tasks in the context of Artemis courses, yet a broader variety could enhance the calendar’s usefulness even further. Personal events could allow learners to add their own events, visible primarily to themselves and optionally shareable with peers. Even though we did not prioritize their implementation, administrative events as initially proposed by this thesis would still provide valuable support for course staff.

Caching strategies represent another direction for improvement. During this thesis, the implementation of caching for the iCalendar endpoint was deliberately deferred. Future development should include monitoring the system under realistic load conditions and, if necessary, introducing caching mechanisms. The Spring Boot caching API together with the existing Hazelcast provider offers a straightforward path toward efficient performance optimization.

Finally, some opportunities exist to enhance the user experience of the calendar. A concrete example concerns the week and day presentations, which allow scrolling but sometimes conceal events. Users may struggle to discover these hidden entries without additional guidance. A small indicator at the top or bottom of columns containing hidden events would ensure visibility and prevent accidental oversights, thereby improving the usability of the calendar.
