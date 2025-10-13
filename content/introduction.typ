#import "/utils/todo.typ": TODO

= Introduction<introduction>
#TODO[
  Introduce the topic of your thesis, e.g. with a little historical overview.
]
The technological changes over the 20th century, up until the beginning of the 21st century, have impacted the educational paradigms of many universities. The standard approach has shifted from face-to-face classroom learning - that is by nature synchronous and location-bound - to a model blending the traditional format with asynchronous and location-independent online learning #cite(<And2020>) #cite(<Des2008>) #cite(<Hara2000>). With this change come advantages, but also some challenges.

The invention of the internet #cite(<Mow2002>) at the end of the 1960s #cite(<Mow2002>) and the rise of personal computers during the end of the 1970s #cite(<Abba1999>) increased public access to digital resources and paved the way for universities to integrate online materials into their curricula. The development of the first learning management systems during the 1990s #cite(<Aldh2024>), which are web applications specifically designed to support teaching, is symptomatic of this trend.

During the Covid-19 pandemic, universities reached a peak in their shift away from traditional teaching models, as many institutions had to suspend in-person classes and transition to online teaching #cite(<Cur2022>). This rapid, mandatory adoption of digital tools during the pandemic played a major role in driving the use of blended learning models in today’s post-pandemic era #cite(<Meg2022>) #cite(<Fil2023>).

Artemis is a learning management system tailored to support university courses, particularly in technical disciplines. It provides a strong example of blended learning in practice. Courses using Artemis typically include lectures scheduled at fixed times, alongside tutorial group sessions, that are individual to students, and multiple smaller exercise assignments that students complete flexibly within a predefined timeframe #footnote[https://docs.artemis.cit.tum.de/index.html].

This blended model offers flexibility in meeting individual student needs by allowing learners to partially determine when and where to engage with course content. However, despite this benefit, there are also some challenges associated with Artemis’s approach.

== Problem<problem>
#TODO[
  Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
]
The increased complexity of the blended course environment amplifies the need for effective planning and personal time management. The classical teaching approach centers learning around lectures. With Artemis, however, courses combine lectures with several exercise formats and tutorial group sessions. Each of these course-related concepts is potentially associated with multiple deadlines and dates. 

Whether an event is relevant to a user can depend on their role in the given course. For instance, the start and end dates of a lecture are relevant for both students and instructors. In contrast, the start and end dates of tutorials are only important to students and tutors of the respective tutorial groups. 

This increased complexity makes it difficult to stay aware of all important dates. Without proper time management, this can have negative implications. When students miss important events, it can negatively impact their learning progress and grades. If course staff members fail to meet their responsibilities, it can disrupt the course schedule, leading to disadvantages for students (e.g., a tutor forgetting a tutorial session) and avoidable additional efforts for staff (e.g., handling student complaints).

Currently, Artemis does not offer a practical, user-friendly tool that clearly communicates important dates in a centralized manner. Users must log in to Artemis and manually navigate through various course components to find relevant events, making personal time management unnecessarily difficult.

== Motivation
To address this issue, integrating a digital calendar into Artemis would provide significant benefits. This calendar would allow students, instructors, editors, and tutors to easily view all important events. By implementing a subscription mechanism, users could synchronize the Artemis calendar with their personal device's calendars, eliminating the need to log in to Artemis and further streamlining the time management process.

Research shows that students who engage with online course features designed to support time management — such as calendars — tend to develop stronger skills in this area #cite(<Miert2015>). In particular, using a subscription mechanism appears to have a positive influence on students' time management #cite(<Mei2016>).

Over the past three decades, literature has consistently linked effective time management with academic success #cite(<Brit1991>) #cite(<Plant2005>) #cite(<Bas2014>) #cite(<Wolt2021>). The proposed calendar feature could therefore play a role in enhancing students' academic performance.

It is reasonable to assume that effective time management is also a significant factor in determining students' stress levels. Literature indicates that students who are still adjusting to the university environment — such as first-year students or high school students enrolled in university courses — often struggle with time management #cite(<Shau2015>) #cite(<Meer2010>). Research further shows that higher digital competence leads to better time management, which in turn reduces academic stress #cite(<Gal2021>). In this context, providing the necessary infrastructure is arguably a prerequisite so that students can develop the digital competencies relevant to effective time management. Hence, introducing a digital calendar could be a sensible measure to reduce stress for some users. 

This idea also aligns with findings from other scientists. Their study describes calendars as a form of cognitive offloading, which they define as using physical aids to reduce cognitive load #cite(<Gilb2023>). The same study mentions that individuals can better engage in mental tasks by offloading other cognitive processes. This implies that the proposed calendar feature could help alleviate mental load, enabling users to concentrate more effectively on other essential activities, such as studying or teaching.
#TODO[
  Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
]


== Objectives
#TODO[
  Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
]
This thesis aims to extend Artemis with a time management feature. The centerpiece of this feature is a calendar that displays all important events related to a course. The calendar supports a variety of event types and provides a mechanism to subscribe external calendar applications through iCalendar feeds. Based on this, we define the following objectives:

==== Support Derived Events
In a first step, we want to enable the calendar to display so-called _Derived Events_. The idea here is to include important dates of objects that are already part of Artemis in the calendar. Examples of such objects include lectures, exercises, tutorial group sessions, and exams. Each of these objects can have multiple date properties from which the system can derive events and include them in the calendar.

==== Enable Lecture Scaffolding and Exercise Planning
Additionally, we address a problem with events derived from lectures and exercises. These events appear only after the course team creates the corresponding lecture or exercise. Since this setup requires effort, the course team often adds them just a few days before the lecture or exercise takes place. We plan to add functionality that allows students to view lecture and exercise events earlier. To achieve this, we aim to extend Artemis to enable the quick scaffolding of lectures without specifying their content, as well as the creation of planned exercises that serve as proxies for real exercises.

==== Provide a Subscription Mechanism
Furthermore, we would like to provide a mechanism for users to subscribe their external calendar applications to the Artemis calendar. The mechanism should conform to the iCalendar standard to ensure broad compatibility with other calendar applications. For each subscription, the user should be able to control what types of events the feed includes and in what language it presents events' details.

==== Support Administrative Events
Finally, we aim to support a second event type alongside Derived Events: Administrative Events. These events are visible only to Course Staff and help coordinate administrative tasks. Course Staff members manage them through a dedicated scheduling component in the course management. This schedule should serve as a shared mental model of the course's outline for the teaching team.

== Outline
#TODO[
  Describe the outline of your thesis
]
The five chapters of this thesis put the proposed feature into perspective, conceptualize its details, and document its implementation. In @introduction, we developed why a time management feature could be of value in the broader context of blended learning, but also specifically in the context of Artemis and from a scientific perspective. We then defined the objectives of this thesis. @relatedWork presents a selection of related work in the field of time management technologies for education. 

@requirements analyzes the requirements of the proposed system by following the FURPS+ approach proposed by Brügge et al #cite(<Brue2014>). This comprises functional requirements, quality attributes, and constraints of the system. The chapter further expands on the requirements by illustrating selected aspects of the system with several system models.

@architecture describes how we transfer application domain concepts from @requirements into the solution domain. This includes specifying design goals, defining the subsystem decomposition, and explaining how we manage persistent data, as well as access control.

@summary summarizes the project by evaluating realized and open goals and reflects on the impact of the work done as part of this thesis. The thesis then concludes by suggesting opportunities for future work.

#pagebreak()

