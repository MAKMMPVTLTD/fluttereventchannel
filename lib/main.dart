import 'package:flutter/material.dart';

import 'events.dart';

void main() => runApp(PlaygroundApp());

class PlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter EventChannel!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Playground(title: 'Event Channel!'),
    );
  }
}

class Playground extends StatefulWidget {
  Playground({Key key, this.title}) : super(key: key);

  final String title;

  @override
  PlaygroundState createState() => PlaygroundState();
}

class PlaygroundState extends State<Playground> {
  var cancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Press button to run!"),
              const Text("-"),
              Text(logs),
              ElevatedButton(
                  onPressed: () {
                    cancel();
                  },
                  child: const Text('Cancel'))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: runPlayground,
          tooltip: 'Run',
          child: const Icon(Icons.play_arrow),
        ));
  }

  String logs = "";

  // Call inside a setState({ }) block to be able to reflect changes on screen
  void log(String logString) {
    logs += logString.toString() + "\n";
  }

  // Main function called when playground is run
  bool running = false;

  void runPlayground() async {
    if (running) return;
    running = true;

    cancel = startListening((msg) {
      setState(() {
        log(msg);
      });
    });

    /* await Future.delayed(Duration(seconds: 15));

    cancel();*/

    running = false;
  }
}
