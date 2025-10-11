import 'package:question_ap/question.dart';

class QuizBrain {
  List<Question> questions = [
    Question('Delhiid heden nar baidag we', true), // 0
    Question('1+1 = 3', false), //1
    Question('Heden uliral baidag we', true), //2
    Question('5 sar baidag uu?', false), //3
    Question('Zun tsas ordog uu', false), //4
    Question('Uvul boroo ordog uu', true), //5
    Question('Mongold dalai baidag uu', true), //6
    Question('Mongold naadam boldog uu', true), //7
  ];

  int questionsNumber = 0;

  String? questionText() {
    return questions[questionsNumber].questionText;
  }

  void nextQuestion() {
    if (questionsNumber < questions.length - 1) {
      questionsNumber += 1;
    }
  }

  //4. zuw hariultiig awdag function
  bool? getCorrectAnswer() {
    return questions[questionsNumber].questionAnswer;
  }

  //5. finished function

  bool? isFinished() {
    print("questionNumber:");

    print(questionsNumber);
    print(questions.length);
    if (questionsNumber >= questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  //6. questionNumber ehnees ehluuluh
  void reset() {
    questionsNumber = 0;
  }
}
