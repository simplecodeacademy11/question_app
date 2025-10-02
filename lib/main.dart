import 'package:flutter/material.dart';
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

class QuestionHome extends StatefulWidget {
  const QuestionHome({super.key});

  @override
  State<QuestionHome> createState() => _QuestionHomeState();
}

class _QuestionHomeState extends State<QuestionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(backgroundColor: Colors.grey.shade900),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.questionText()!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {
                  quizBrain.nextQuestion();
                },
                child: Text('True', style: TextStyle(fontSize: 20, color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: () {},
                child: Text('False', style: TextStyle(fontSize: 20, color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
