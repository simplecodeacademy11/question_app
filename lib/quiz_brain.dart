import 'package:question_ap/question.dart';

class QuizBrain {
  List<Question> questions = [
    Question('Delhiid heden nar baidag we', true),
    Question('1+1 = 3', false),
    Question('Heden uliral baidag we', true),
    Question('3 sar baidag', false),
  ];

  int questionsNumber = 0;

  String? questionText() {
    return questions[questionsNumber].questionText;
  }

  void nextQuestion() {
    if (questionsNumber < questions.length - 1) {
      questionsNumber++;
    }
  }
}
