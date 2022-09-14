import 'package:flutter/material.dart';
import 'package:quizoid/const.dart';
import 'package:quizoid/topic_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kprimarycolor,
        brightness: Brightness.dark,
      ),
      home: const TopicScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
