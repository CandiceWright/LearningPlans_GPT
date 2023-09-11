import 'package:flutter/material.dart';
import 'package:learningplans_app/models/learning_prompt.dart';
import 'package:learningplans_app/models/study_plan_chapter.dart';
import 'package:learningplans_app/results_page.dart';
import 'package:learningplans_app/services/server_service.dart';
import 'package:numberpicker/numberpicker.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage(
      {super.key, required this.title, required this.prompt});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final LearningPrompt prompt;

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Build a weekly study plan to learn ${widget.prompt.topic} in ${widget.prompt.weeks} weeks, studying ${widget.prompt.hoursPerDay} hours per day.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String completePrompt =
                    "Build me a weekly study plan to learn ${widget.prompt.topic} in 16 weeks, studying ${widget.prompt.weeks} weeks, studying ${widget.prompt.hoursPerDay} hours per day. Format your response as a json array and use this json as an example: { 'week': 'Week 1', 'title': 'Introduction to Data Analytics', 'description': 'In this week, you will be introduced to the basics of data analytics, including key concepts, tools, and techniques.', 'topics': [ 'Introduction to data analytics', 'Importance of data analytics', 'Data analytics process', 'Key tools and technologies' ], 'resources': [ { 'title': 'Data Analytics: A Comprehensive Beginner's Guide', 'url': 'https://www.analyticsvidhya.com/blog/2018/05/data-analytics-beginners-guide/' }, { 'title': 'Introduction to Data Analytics - Tutorial', 'url': 'https://www.tutorialspoint.com/data_analytics/data_analytics_introduction.htm'} ] }} ] } ";
                List<StudyPlanChapter> weeklyStudyPlan = await ServerService
                    .sharedInstance
                    .getLearningPlan(completePrompt);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ResultsPage(
                      title: widget.title, studyPlan: weeklyStudyPlan),
                ));
              },
              child: const Text("Build my learning Plan"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      //const Color(0xffd1849e),
                      Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                              //color: Color(0xffd1849e),
                              color: Colors.white)))),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
