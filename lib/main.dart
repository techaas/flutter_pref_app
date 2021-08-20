// Copyright 2021, Techaas.com. All rights reserved.
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  SharedPreferencesDemo({Key key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _cancelPressed() {
    _loadCounter();
  }

  _loadCounter() async {
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        _counter = prefs.getInt('counter');
      });
    });
  }

  void _okPressed() async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt('counter', _counter);
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: Stack(children: <Widget>[
        Container(
          color: Color.fromARGB(32, 0, 255, 255),
        ),
        Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topRight,
            // color: Color.fromARGB(32, 255, 255, 0),
            child: Container(
                padding: EdgeInsets.all(15),
                width: 400.0,
                height: 200.0,
                color: Color.fromARGB(128, 255, 255, 0),
                child: Column(children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Expanded(
                      child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline5,
                  )),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new TextButton(
                        child: new Text('Cancel'),
                        onPressed: _cancelPressed,
                      ),
                      new ElevatedButton(
                        child: new Text('OK'),
                        onPressed: _okPressed,
                      ),
                    ],
                  ),
                ])))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
