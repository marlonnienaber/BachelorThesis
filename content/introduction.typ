#import "/utils/todo.typ": TODO

= Introduction
#TODO[
  Introduce the topic of your thesis, e.g. with a little historical overview.
]
Technological change over the 20th century up until the beginning of the 21th century has impacted the educational paradigm of many universities. The common approach has shifted from face-to-face classroom learning - that is by nature synchronous and location-bound - to a model blending the classic format with asynchronous and location-independent online learning #cite(<And2020>) #cite(<Des2008>) #cite(<Halv2009>) #cite(<Hara2000>).

/*
Universities made the first steps towards this direction around the middle of the 20th century up until the 70s where academic institutions experimented with delivery knowledge through media channels such as radio and television #cite(<Halv2009>). A good example for this is the British Open University. Students could access its learning material mainly via TV and radio shows broadcasted by the BBC or through recordings made accessible in one of the numerous study centers across the UK #cite(<ou2018>).

what about local networks?
*/

The first step towards this trend was the start of the construction of the ARPANET computer network in 1969 #cite(<Hara2000>). This network is today widely recognized to be the earliest precursor of the internet #cite(<Mow2002>). This development paved the way for universities to begin integrating early networking technologies into education in the 1970s, including tools such as email and text-based computer conferencing #cite(<Hara2000>).

The late 1970s mark the beginning of the personal computing era, with Apple introducing the Apple II in 1977 — the first widely successful home computer #cite(<Abba1999>). This development significantly increased public access to digital resources. Over the years of the 1980s, professors also began offering the first fully online university courses, using text- and messaging-based systems to deliver instruction and enable student interaction #cite(<Weiss2006>).

In 1989 Tim Berners-Lee started the World Wide Web project at the CERN in Switzerland #cite(<cern>). The inventions resulting from this project introduced the hyper text format that most people associate the internet with today #cite(<Mow2002>). Building on this technological shift, the first learning management systems were developed over the 90s #cite(<Aldh2024>). These systems are web applications that are specifically developed to support teaching. #TODO[maybe research actual definition and add source]

Over the following two decades, online availability of learning content continued to consolidate. The launch of so-called massive open online courses (MOOCs) in 2012 #cite(<yearOfMooc>) was symptomatic of this trend. MOOCs aim to provide open access to high-quality learning content to reach a broad audience #cite(<Li2019>). At first, this approach may seem at odds with traditional university teaching, which typically serves only enrolled students. However, the  materials offered through MOOCs also represented an opportunity for universities to integrate online resources into a blended learning environment #cite(<Li2019>).

During the Covid-19 pandemic, universities reached a peak in their shift away from traditional teaching models, as many institutions had to suspend in-person classes and transition to online teaching #cite(<Cur2022>). This rapid, mandatory adoption of digital tools during the pandemic certainly played a major role in driving the use of blended learning models in today’s post-pandemic era #cite(<Meg2022>) #cite(<Fil2023>).

Artemis is a learning management system tailored to support university courses, particularly in technical disciplines. It provides a strong example of blended learning in practice. Courses using Artemis typically include lectures scheduled at fixed times, alongside tutorial group sessions that are individual to students and multiple smaller exercise assignments that students complete flexibly within a predefined timeframe #cite(<ArtemisDoku>). This structure reflects a hybrid educational model that integrates synchronous, location-bound elements with asynchronous, location-independent activities.

This model offers room for flexibility when it comes to individual student needs, allowing learners to partially decide when and where to engage with course content. Artemis further supports individualization through its adaptive learning path feature, introduced by Maximilian Anzinger #cite(<Anz2023>). However, despite these benefits, there are also pedagogical challenges associated with Artemis’s approach.

== Problem<problem>
#TODO[
  Describe the problem that you like to address in your thesis to show the importance of your work. Focus on the negative symptoms of the currently available solution.
]
The increased complexity of a blended course environment certainly amplifies the need for planning and personal time management for both teachers and students. In a classical teaching approach, everyone followed the same fixed course schedule, making it easy to know when and where to be. With Artemis, however, the events that make up the course schedule can vary from person to person. To understand why this is the case, it’s important to first provide some context about Artemis.

Artemis mainly revolves around the concept of a course. A course, consists of several concepts including lectures, tutorial groups, exams and several exercise formats. Students attend lectures and tutorials, participate in exams, and complete exercises. Course staff members - consisting of instructors, editors, and tutors - hold lectures and tutorials, conduct exams,
and assess exercises. 

Each of the course-related concepts is potentially associated to multiple deadlines and dates. Whether an event is relevant to a user depends on his role in the given course. For instance, the start and end date of a lecture are relevant for both students and course staff members, while the release date of lectures, exercises and exams are only important to course staff. Then again the start and end date of a tutorial are only relevant for the students and tutors of the respective tutorial group. There are many more examples that will be thoroughly addressed in @requirements.

When students miss important events, it can negatively impact their learning progress and grades. If course staff members fail to meet their responsibilities, it can disrupt the course schedule, leading to disadvantages for students (e.g., a tutor forgetting a tutorial session) and avoidable additional efforts for staff (e.g., handling student complaints). 

This highlights the importance of clearly communicating individual course schedules to Artemis course participants. Currently, Artemis does not offer an effective, user-friendly tool for this purpose. Users must log in and manually navigate through various course components to find relevant events, making personal time management unnecessarily difficult. Since there is no centralized component that presents all important dates in one place, the process becomes cumbersome, and inefficient.

== Motivation
To address this issue, integrating a calendar into Artemis would be of great value. This component would allow students, instructors, editors, and tutors to easily view all relevant events in a centralized manner. By implementing a subscription mechanism, users could synchronize the Artemis calendar with their personal device's calendars, eliminating the need to log into Artemis and further streamlining the time management process. The ability to set reminders for calendar events via Artemis's existing notification system provides an extra layer of memory support.Add commentMore actions

Research shows that students who engage with online course features designed to support time management — such as calendars — tend to develop stronger skills in this area #cite(<Miert2015>). In particular, using a subscription mechanism appears to positively influence students' time management #cite(<Mei2016>).

Over the past three decades, literature has consistently linked effective time management with academic success #cite(<Brit1991>) #cite(<Plant2005>) #cite(<Bas2014>) #cite(<Wolt2021>). The proposed calendar feature could therefore play a role in enhancing students' academic performance.

It is reasonable to assume that effective time management is also a significant factor in determining students' stress levels. Literature indicates that students who are still adjusting to the university environment — such as first-year students or high school students enrolled in university courses — often struggle with managing their time #cite(<Shau2015>) #cite(<Meer2010>). Research further shows that higher digital competence leads to better time management, which in turn reduces academic stress #cite(<Gal2021>). In this context, the university's provision of the necessary infrastructure is arguably a prerequisite for students to develop the digital competencies relevant to effective time management. Hence, introducing a digital calendar could be a sensible measure to reduce stress for some users. 

This idea also aligns with findings from other scientists. Their study describes calendars as a form of cognitive offloading, which they define as using physical aids to reduce cognitive load #cite(<Gilb2023>). The same study mentions that individuals can better engage in mental tasks by offloading other cognitive processes. This implies that the proposed calendar feature could help alleviate mental load, enabling users to concentrate more effectively on other essential activities such as studying or teaching.
#TODO[
  Motivate scientifically why solving this problem is necessary. What kind of benefits do we have by solving the problem?
]


== Objectives
#TODO[
  Describe the research goals and/or research questions and how you address them by summarizing what you want to achieve in your thesis, e.g. developing a system and then evaluating it.
]
- add a calendar that displays coursewide and tutorial events
- add a course schedule page where coursewide events can be managed
- enable users to subscribe to the Artemis calendar

== Outline
#TODO[
  Describe the outline of your thesis
]