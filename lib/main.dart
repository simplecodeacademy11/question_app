import 'package:flutter/material.dart';
import 'package:question_ap/question_home.dart';
import 'package:question_ap/quiz_brain.dart';

void main() {
  runApp(const MyApp());
}

QuizBrain quizBrain = QuizBrain();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const QuestionHome(),
    );
  }
}
