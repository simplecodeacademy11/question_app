import 'package:flutter/material.dart';
import 'package:question_ap/list_score.dart';
import 'package:question_ap/main.dart';

class QuestionHome extends StatefulWidget {
  const QuestionHome({super.key});

  @override
  State<QuestionHome> createState() => _QuestionHomeState();
}

class _QuestionHomeState extends State<QuestionHome> {
  List<Icon> scoreKeeper = [];

  int score = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool? correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        quizBrain.reset();
        scoreKeeper = [];
        score = 0;
      } else {
        if (userPickedAnswer == correctAnswer) {
          score += 1;
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(backgroundColor: Colors.grey.shade900),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                score.toString(),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
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
                    checkAnswer(true);
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
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text('False', style: TextStyle(fontSize: 20, color: Colors.white)),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ),

            ListScore(listScore: scoreKeeper),
          ],
        ),
      ),
    );
  }
}
