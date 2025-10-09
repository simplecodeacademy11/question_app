// import 'package:flutter/material.dart';
// import 'package:question_ap/question_home.dart';
// import 'package:question_ap/quiz_brain.dart';

// void main() {
//   runApp(const MyApp());
// }

// QuizBrain quizBrain = QuizBrain();

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
//       home: const QuestionHome(),
//     );
//   }
// }

import 'package:flutter/material.dart';

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

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 2; // “Question 3 of 10” (0-indexed)
  int totalQuestions = 10;
  int? selectedIndex;
  bool liked = false;

  final options = const [
    AnswerOption(text: 'Labrador Retriever', isCorrect: false),
    AnswerOption(text: 'Siberian Husky', isCorrect: true),
    AnswerOption(text: 'Golden Retriever', isCorrect: false),
  ];

  @override
  Widget build(BuildContext context) {
    final progress = (currentQuestion + 1) / totalQuestions;

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
                // Top bar: close, progress, like
                Row(
                  children: [
                    _circleIcon(context, icon: Icons.close, onTap: () {}),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                          backgroundColor: Colors.white.withOpacity(.25),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2DE370)),
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

                // Image + tilted question bubble
                _QuestionCard(),

                const SizedBox(height: 16),

                // Options
                ...List.generate(options.length, (i) {
                  final opt = options[i];
                  final tapped = selectedIndex != null && selectedIndex == i;
                  final answered = selectedIndex != null;

                  // Color logic
                  Color bg = Colors.white.withOpacity(.18);
                  Color border = Colors.white.withOpacity(.18);
                  IconData? trailing;
                  Color? trailingBg;

                  if (answered) {
                    if (opt.isCorrect) {
                      bg = const Color(0xFF2DE370);
                      border = const Color(0xFF2DE370);
                      trailing = Icons.check_rounded;
                      trailingBg = Colors.white;
                    } else if (tapped && !opt.isCorrect) {
                      bg = const Color(0xFFFF5656);
                      border = const Color(0xFFFF5656);
                      trailing = Icons.close_rounded;
                      trailingBg = Colors.white;
                    } else {
                      // keep neutral for untouched wrongs
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
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
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
                                  color: (opt.isCorrect) ? const Color(0xFF2DE370) : const Color(0xFFFF5656),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // Next button
                FilledButton(
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
                          // demo next
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
}

class _QuestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _glass(blur: 10, bg: Colors.white.withOpacity(.15), radius: 28),
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Container(
                color: const Color(0xFFEAF3FF),
                child: Image.network(
                  'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=1200&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Tilted bubble text
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Transform.rotate(
                angle: -0.07, // little tilt like the mock
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 360),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6E7F8F).withOpacity(.85),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(.65), width: 3),
                    boxShadow: [
                      BoxShadow(blurRadius: 24, color: Colors.black.withOpacity(.18), offset: const Offset(0, 8)),
                    ],
                  ),
                  child: const Text(
                    'Question 3 of 10\nWhich breed is considered one of the most semi-polar dog breeds in the USA?',
                    style: TextStyle(height: 1.2, fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _glass({required double blur, required Color bg, required double radius}) {
  return BoxDecoration(
    color: bg,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: Colors.white.withOpacity(.35), width: 2),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 24, offset: const Offset(0, 8))],
  );
}

class AnswerOption {
  final String text;
  final bool isCorrect;
  const AnswerOption({required this.text, required this.isCorrect});
}
