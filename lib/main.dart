import 'package:flutter/material.dart';
import 'package:question_ap/quiz_brain.dart';
import 'package:question_ap/question_home.dart';
import 'package:question_ap/result_page.dart';

QuizBrain quiz = QuizBrain();

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Puppy Quiz',
      theme: ThemeData(useMaterial3: true, fontFamily: 'SF Pro', colorSchemeSeed: const Color(0xFF7A3DF0)),
      home: const QuizScreen(),
    );
  }
}

class AnswerOption {
  final String text;
  final bool isCorrect;
  const AnswerOption({required this.text, required this.isCorrect});
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int? selectedIndex;
  bool liked = false;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    final totalQuestions = quiz.questions.length;
    final progress = (currentQuestion + 1) / totalQuestions; //8/8 = 0,2

    final q = quiz.questions[currentQuestion];

    final List<AnswerOption> options = const [
      AnswerOption(text: 'Тийм', isCorrect: true),
      AnswerOption(text: 'Үгүй', isCorrect: false),
      AnswerOption(text: 'Medehgui', isCorrect: false),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8D36FF), Color(0xFFB649FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                          backgroundColor: Colors.white.withOpacity(.25),
                          valueColor: const AlwaysStoppedAnimation(Color(0xFF2DE370)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _circleIcon(
                      context,
                      icon: liked ? Icons.favorite : Icons.favorite_border,
                      onTap: () => setState(() => liked = !liked),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                QuestionCard(question: q.questionText ?? '', index: currentQuestion, total: totalQuestions),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (context, i) {
                      final opt = options[i];
                      final answered = selectedIndex != null;
                      final tapped = selectedIndex == i;

                      final bool correctValue = q.questionAnswer == true;

                      Color bg = Colors.white.withOpacity(.18);
                      Color border = Colors.white.withOpacity(.18);
                      IconData? trailing;
                      Color? trailingBg;

                      if (answered) {
                        final isThisCorrect = opt.isCorrect == correctValue;

                        if (isThisCorrect) {
                          bg = const Color(0xFF2DE370);
                          border = const Color(0xFF2DE370);
                          trailing = Icons.check_rounded;
                          trailingBg = Colors.white;
                          score += 1;
                        } else if (tapped && !isThisCorrect) {
                          bg = const Color(0xFFFF5656);
                          border = const Color(0xFFFF5656);
                          trailing = Icons.close_rounded;
                          trailingBg = Colors.white;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: answered ? null : () => setState(() => selectedIndex = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: border, width: 2),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    opt.text,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (trailing != null)
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(color: trailingBg, shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      trailing,
                                      size: 22,
                                      color: (opt.isCorrect == correctValue)
                                          ? const Color(0xFF2DE370)
                                          : const Color(0xFFFF5656),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                currentQuestion == 7
                    ? FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResultPage(score: score, total: totalQuestions),
                            ),
                          );
                        },

                        child: const Text('Result Page'),
                      )
                    : FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF7A3DF0),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        ),
                        onPressed: selectedIndex == null
                            ? null
                            : () {
                                setState(() {
                                  selectedIndex = null;
                                  currentQuestion = (currentQuestion + 1) % totalQuestions;
                                });
                              },
                        child: const Text('Next'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _circleIcon(BuildContext context, {required IconData icon, VoidCallback? onTap}) {
  return InkResponse(
    onTap: onTap,
    radius: 24,
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: Colors.white.withOpacity(.25), shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 20),
    ),
  );
}
