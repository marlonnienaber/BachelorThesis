#import "/utils/todo.typ": TODO

= Related Work<relatedWork>
#TODO[
  Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was al- ready solved by XYZ.” If you have multiple related works, use subsections to separate them.
]
In the following paragraphs, we first define the term time management as understood in this thesis to set the context for related work. We then proceed to present a selection of work that other researchers have done in the field, utilizing mobile and web-based technologies. Finally, we present some work related to the iCalendar standard. 

== Time Management Technology <defintionAndApproachesTimeManagementTech>
Individuals typically strive to accomplish various tasks in order to achieve their personal goals. Time management means deciding when to complete which of those tasks. Many tools that support time management follow one of two approaches: 

The first is the task-oriented approach: the tools falling into this category manage tasks directly by collecting them and presenting them to the user. Each task typically includes a description that specifies the required action as well as temporal metadata defining when the action should start and/or end. Commercial tools that use this approach include Apple Reminders #footnote[https://support.apple.com/de-de/guide/reminders/welcome/mac], Google Tasks #footnote[https://support.google.com/tasks/answer/7675772], Microsoft To Do #footnote[https://www.microsoft.com/de-de/microsoft-365/microsoft-to-do-list-app], and Todoist #footnote[https://www.todoist.com/de].

The second approach focuses on managing so-called events, which are temporal structures that constrain when individuals can complete certain tasks. An event typically has a descriptive title and a start date; in this case, it represents a single point in time. If it also has an end date, the event represents a time period. For example, an assignment deadline marks a specific point in time that limits when a student can finish writing the assignment. However, the connection between an event and the tasks it affects is not always explicit. A lecture, for instance, may indirectly constrain when a student can do his daily workout. Commercial tools that follow the event-oriented approach include Apple Calendar #footnote[https://support.apple.com/de-de/guide/calendar/welcome/mac], Outlook Calendar #footnote[https://support.microsoft.com/en-us/office/introduction-to-the-outlook-calendar-d94c5203-77c7-48ec-90a5-2e2bc10bd6f8], and Google Calendar #footnote[https://support.google.com/calendar/#topic=10509740].

== Mobile Time Management Technology

In educational settings, researchers have explored several projects aimed at improving time management. Mobile applications, in particular, have emerged as a popular medium for delivering such solutions:

The task-oriented mobile app called _MyLearningMentor_ was developed in 2014 and aimed to lower the entry barrier for learning with MOOCs. Alario-Hoyos et al. argued that "the lack of support and personalized advice in MOOCs is causing that many of the learners that have not developed work habits and self-learning skills give them up at the first obstacle, and do not see MOOCs as an alternative for their education and training" #cite(<Alar2014>).

In their paper, the authors present the first prototype of _MyLearningMentor_, which addresses this problem through automated task planning tailored to individual learners. Users can add MOOCs they want to complete. The system then scrapes the hosting platform, extracts the relevant course tasks, and generates a personalized task schedule using a recommender system. This system relies on the added courses, as well as the learner's "4Ps": Profile (e.g., age), Preferences (e.g., available study hours), Priorities (e.g., which courses to prioritize), and Performance (e.g., the number of previously completed tasks).

A further contribution to time management technology is the _Zooming-UI-Calendar-App_ that Hunt et al. first proposed in 2014 #cite(<Hun2014>). The authors propose an at-the-time novel, event-oriented user interface concept for digital calendar apps. Instead of mimicking analog calendars with multiple grid views (for example, a month view or a week view), the Zooming-UI-Calendar-App presents events in a zoomable list view that represents a timeline. Users can scroll and zoom the timeline. This results in a multi-granular behavior, where the level of detail displayed for each event increases or decreases depending on the zoom factor.

The authors argue that this interface concept enables faster calendar searches while also offering a more intuitive way of interacting. They further claim that the concept is particularly well-suited for mobile applications. In 2016 and 2017, they implemented a prototype #footnote[https://dl.gi.de/items/0f5b2611-c642-42a7-9ec5-280c6b33f9d3] and evaluated #footnote[https://dl.gi.de/items/79a21aa1-1681-4ab7-8c3b-d0c791ea6406] it with a small sample of participants. The evaluation results overall supported their claims.

== Web-Based Time Management Technology

Scientific literature on educational time management tools in a web application context is very limited. Nevertheless, learning management systems, which are typically web-based, commonly include calendar tools #cite(<Lla2011>).

Literature highlights Moodle, Canvas, Blackboard, and Brightspace as some of the most common LMS #cite(<Sim2024>). This aligns with data from multiple consultancy institutions that have studied the LMS market #footnote[https://onedtech.philhillaa.com/p/observations-on-higher-ed-lms-market] #footnote[https://onedtech.philhillaa.com/p/state-of-higher-ed-lms-market-for-us-and-canada-year-end-2024-edition] #cite(<Sim2024>). All of these LMS include primarily event-oriented calendars that share similar characteristics. Some literature reports positive user feedback on the calendar tools in Canvas #cite(<Irv2022>) and Moodle #cite(<Goy2015>). Taken together with the fact that all market-leading LMS support a calendar feature, this suggests the usefulness of such a tool. The following paragraphs analyze the calendars of the aforementioned market leaders, based on their official documentation.

#figure(
      image(
        "../figures/CanvasCalendar.png", width: 85%,
      ),
      caption: [Canvas global calendar],
)<canvasCalendar>

Moodle and Blackboard support both global calendars, meaning they include events from multiple courses, and course-level calendars, where the calendar is located on a course page and does not include events related to other courses. Canvas and Brightspace, by contrast, only provide a global calendar combined with filters that allow users to hide or show events from specific courses. @canvasCalendar, @blackboardCalendar, @brightspaceCalendar, and @moodleCalendar show the global calendars of the four platforms.

The platforms also differ in how they present events. Moodle supports only a month view. Canvas displays events by month or week, while Blackboard allows users to choose between a month or day view. Brightspace offers all three options: month, week, and day view.

#figure(
      image(
        "../figures/BlackboardCalendar.png", width: 85%,
      ),
      caption: [Blackboard global calendar],
)<blackboardCalendar>

The systems further vary in the types of events their calendars can display. Moodle supports four types of events: personal events, which remain private to the user; group events, visible only to members of a specific group; course events, accessible to all course participants; and global events, visible to all users. Canvas includes the same event types as Moodle, except for global events. Blackboard and Brightspace restrict support to personal and course events.

All of the platforms include controls for navigating to the previous or next instance of the current view. In addition, every platform except Moodle provides a “today” button that allows users to jump directly to the view that contains the current day.

#figure(
      image(
        "../figures/MoodleCalendar.png", width: 85%,
      ),
      caption: [Moodle global calendar],
)<moodleCalendar>

Each LMS also supports interoperability with external calendar tools through the iCalendar standard, allowing for the import or export of events. This functionality can rely on static .ics files or on dynamic .ics subscription feeds. Moodle supports both import and export through files and feeds. Canvas does not support imports, but it allows exports via file or feed. Blackboard allows imports via file and exports via feed, while Brightspace supports imports via file and exports via both file and feed.

Finally, each calendar includes exclusive features not available on the other platforms. Moodle provides an upcoming events block that displays a configurable number of upcoming events relative to the current moment. Canvas, on the other hand, offers an agenda view that chronologically lists all events within a selected date range, as well as a scheduler view that enables students to schedule appointments with instructors. Blackboard includes a due dates view that focuses on items with an associated deadline. Finally, Brightspace features an agenda view and a list view where the user can group and filter events by several categories. The so-called task pain further adds a task-oriented feature to Brightspace.

#figure(
      image(
        "../figures/BrightspaceCalendar2.png", width: 85%,
      ),
      caption: [Brightspace global calendar],
)<brightspaceCalendar>

== iCalendar Subscriptions

The ability to export events as an iCalendar subscription is a common feature of event-oriented calendar applications. In 2016, Mei investigated the effect of this technology on students with weak time management skills #cite(<Mei2016>). The study presented a tool called _Course Hack_, which allows teachers to upload syllabi and automatically generate an iCalendar feed that students can use to populate their personal digital calendars.

To evaluate the tool’s effectiveness, Mei conducted a survey with 47 undergraduate students who had used it during their studies. The findings revealed that although 85.4% of participants reported using a calendar in college, 51.2% did not record important dates such as deadlines or exams in their personal calendars. This suggests that many students did not use their calendars effectively. The survey further indicated that the majority of students felt the tool helped them become more aware of important deadlines and course-related dates, start coursework earlier, submit assignments on time, and manage their time more effectively overall.

These findings, together with the widespread adoption of iCalendar subscription feeds in market-leading LMS, provide a strong rationale for incorporating iCalendar subscriptions into the feature implemented by this thesis.

#pagebreak()