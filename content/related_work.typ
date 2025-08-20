#import "/utils/todo.typ": TODO

= Related Work
#TODO[
  Describe related work regarding your topic and emphasize your (scientific) contribution in contrast to existing approaches / concepts / workflows. Related work is usually current research by others and you defend yourself against the statement: “Why is your thesis relevant? The problem was al- ready solved by XYZ.” If you have multiple related works, use subsections to separate them.
]

== Definition of Time Management and Approaches in Time Management Technology
To put other work related to time management technologies into perspective it first follows a definition of the term time management as understood in this thesis. Individuals usually strive to complete various tasks in order to reach personal goals. Time management means deciding when to complete which task. Many tools that support time management follow one of two approaches: 

Most tools that support time management follow one of two approaches. The first is task-oriented: these tools manage tasks directly by collecting them and presenting them to the user. Each task typically includes a description that specifies the required action and temporal metadata that defines when the action should start and/or end. Commercial tools that use this approach include Apple Reminders #cite(<AppleRemindersDocu>), Google Tasks #cite(<GoogleTasksDocu>), Microsoft To Do #cite(<MicrosoftToDoDocu>) and Todoist #cite(<TodoistWebsite>).

The second approach focuses on managing so-called events which are temporal structures that constrain when individuals can complete certain tasks. An event typically has a descriptive title and a start date; in this case it represents a single point in time. If it also has an end date, the event represents a time period. For example, an assignment deadline marks a specific point in time that limits when a student can finish writing the assignment. However, the connection between an event and the tasks it affects is not always explicit. A lecture, for instance, may indirectly constrain when a student can do his daily workout. Commercial tools that follow the event-oriented approach include Apple Calendar #cite(<AppleCalendarDocu>), Outlook Calendar #cite(<OutlookCalendarDocu>) and Google Calendar #cite(<GoogleCalendarDocu>). 

== Mobile Time Management Technology in Education

In educational settings, researchers have explored several projects aimed at improving time management. Mobile applications, in particular, have emerged as a popular medium for delivering such solutions:

In 2023, Grant developed a prototype for a task-oriented time management tool called the _Student Planner App_ #cite(<Gra2023>). The app manages tasks within a specific university course. Each task contains subtasks and includes both a start and due date. The system calculates a “health value” for each task based on subtask completion and the remaining time until the due date.

The app presents this information in several views. A monthly calendar view shows the tasks that can be worked on each day. For every day, the system computes a health value by combining the health scores of that day’s tasks with the number of tasks scheduled. The calendar colors each day accordingly, creating a heat-map-like appearance. Students can also access a list view that sorts tasks in ascending order of health value.

To increase engagement, the app integrates gamification features. A progress view displays a car on a progress bar that symbolizes the student’s advancement, alongside virtual opponents the student aims to surpass. A challenges list further motivates students by prompting them to complete tasks with low health values or tasks close to their due dates.

Another task-oriented mobile app called _MyLearningMentor_, that was developed in 2014, aimed to lower the entry barrier for learning with MOOCs. Alario-Hoyos et al. argued that "the lack of support and personalized advice in MOOCs is causing that many of the learners that have not developed work habits and self-learning skills give them up at the first obstacle, and do not see MOOCs as an alternative for their education and training" #cite(<Alar2014>).

In their paper, the authors present the first prototype of _MyLearningMentor_, which addresses this problem through automated task planning tailored to individual learners. Users can add MOOCs they want to complete. The system then scrapes the hosting platform, extracts the relevant course tasks, and generates a personalized task schedule with the help of a recommender system. This system relies on the added courses, as well as the learner’s "4Ps": Profile (e.g., age), Preferences (e.g., available study hours), Priorities (e.g., which courses to prioritize), and Performance (e.g., the number of previously completed tasks).

A further contribution to time management technology is the _Zooming-UI-Calendar-App_ that was first proposed by Hunt et al in 2014 #cite(<Hun2014>). The authors propose an at the time novel, event oriented user interface concept for digital calendar apps. Instead of mimicking analog calendars with several grid views (for example, a month view or a week view), the Zooming-UI-Calendar-App presents events in a zoomable list view representing a timeline. Users can scroll and zoom the timeline. This causes a multi-granular behavior where the level of detail shown for each event increases or decreases depending on the zoom factor.

The authors argue that this interface concept enables faster calendar searches while also offering a more intuitive way of interacting. They further claim that the concept is particularly well suited for mobile applications. In 2016 and 2017, they implemented a prototype and evaluated it with a small sample of participants #cite(<Hun2016>) #cite(<Hun2017>). The evaluation results overall supported their claims.

== Web-Based Time Management Technology in Education

Scientific literature on educational time management tools in a web app context is very limited. Nevertheless, learning management systems, which are typically web-based, commonly include calendar tools #cite(<Lla2011>).

Literature highlights Moodle, Canvas, Blackboard, and Brightspace as some of the most common LMS #cite(<Sim2024>). This aligns with data from multiple consultancy institutions that have studied the LMS market #cite(<Hill2024>) #cite(<Hill2025>) #cite(<Sim2024>). All of these LMS include primarily event-oriented calendars that share similar characteristics. Some literature reports positive user feedback on the calendar tools in Canvas #cite(<Irv2022>) and Moodle #cite(<Goy2015>). Taken together with the fact that all market-leading LMS support a calendar feature, this suggests the usefulness of such tools. The following paragraphs analyze the calendars of the aforementioned market-leading platforms, based on their official documentation #cite(<MoodleCalendarDocs>) #cite(<CanvasCalendarDocs>) #cite(<BlackboardCalendarDocs>) #cite(<BrightspaceCalendarDocs>).

Moodle and Blackboard support both global calendars, meaning they include events from multiple courses, and course-level calendars, where the calendar is located on a course page and does not include events related to other courses. Canvas and Brightspace, by contrast, only provide a global calendar combined with filters that allow users to hide or show events from specific courses.

The platforms also differ in how they present events. Moodle supports only a monthly view. Canvas displays events by month or week, while Blackboard allows users to choose between a monthly or daily view. Brightspace offers all three options: monthly, weekly, and daily.

The systems further vary in the types of events their calendars can display. Moodle supports personal events that remain private to the user, group events visible only to members of a specific group, course events accessible to all course participants, and global events visible to all users. Canvas includes the same event types as Moodle, except for global events. Blackboard and Brightspace restrict support to personal and course events.

All of the platforms include controls for navigating to the previous or next instance of the current view. In addition, every platform except Moodle provides a “today” button that allows users to jump directly to the view that contains the current day.

Each LMS also supports interoperability with external calendar tools through the iCalendar standard, enabling event import or export. This functionality can rely on static ICS files or on dynamic ICS subscription feeds. Moodle supports both import and export through files and feeds. Canvas does not support imports but allows export via file or feed. Blackboard allows imports via file and export via feed, while Brightspace supports import via file and export via both file and feed.

Finally, each calendar includes exclusive features not available on the other platforms. Moodle provides an upcoming events block that displays a configurable number of upcoming events relative to the current moment. Canvas on the other hand offers an agenda view that chronologically lists all events in a selected date range, as well as a scheduler view that allows students to arrange appointments with instructors. Blackboard includes a due dates view that focuses on items with an associated deadline. Finally, Brightspace features an agenda view and a list view where the user can group and filter events by several category. The so-called task pain further adds a task-oriented feature to Brightspace.

== iCalendar Subscriptions

As became clear during the previous paragraphs, the ability to export calendar events as an iCalendar subscription is a popular feature. In 2016, Mei investigated the effect of this technology on students with weak time management skills #cite(<Mei2016>). The study presented a tool called Course Hack, which allows teachers to upload syllabi and automatically generate an iCalendar feed that students can use to populate their personal digital calendars.

To evaluate the tool’s effectiveness, Mei conducted a survey with 47 undergraduate students who had used it during their studies. The findings revealed that although 85.4% of participants reported using a calendar in college, 51.2% did not record important dates such as deadlines or exams in their personal calendars. This suggests that many students did not use their calendars effectively. The survey further indicated that the majority of students felt the tool helped them become more aware of important deadlines and course-related dates, start coursework earlier, submit assignments on time, and manage their time more effectively overall.

These findings, together with the widespread adoption of iCalendar subscription feeds in market-leading LMS, provide a strong rationale for incorporating such a feature into the calendar built for Artemis as part of this thesis.