import 'package:flutter/material.dart';
import 'package:learningplans_app/confirmation_page.dart';
import 'package:learningplans_app/models/learning_prompt.dart';
import 'package:numberpicker/numberpicker.dart';

class TimeSelectionPage extends StatefulWidget {
  const TimeSelectionPage(
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
  State<TimeSelectionPage> createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    int weeks = 0;
    int hoursPerDay = 0;

    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            Text(
              "How many weeks do you want to dedicate to learning ${widget.prompt.topic} (Let's Be Realistic!)?",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: StatefulBuilder(
                builder: (context4, setState) {
                  return NumberPicker(
                    textStyle: const TextStyle(color: Colors.grey),
                    selectedTextStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    value: weeks,
                    minValue: 0,
                    maxValue: 100,
                    onChanged: (value) => setState(() => weeks = value),
                  );
                },
              ),
            ),
            const Text(
              "How many hours per day can you spend on this?",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: StatefulBuilder(
                builder: (context4, setState) {
                  return NumberPicker(
                    textStyle: const TextStyle(color: Colors.grey),
                    selectedTextStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    value: hoursPerDay,
                    minValue: 0,
                    maxValue: 24,
                    onChanged: (value) => setState(() => hoursPerDay = value),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.prompt.hoursPerDay = hoursPerDay;
                widget.prompt.weeks = weeks;

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConfirmationPage(
                      title: widget.title, prompt: widget.prompt),
                ));
              },
              child: const Text("Next"),
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
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(4),
        child: Text(
          "Created by Candice Wright & Powered by OpenAI's GPT-3.5",
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
