// question_home.dart (эсвэл QuestionCard байгаа файл)

import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final int index; // 0-based
  final int total;
  final String? imageUrl;

  const QuestionCard({super.key, required this.question, required this.index, required this.total, this.imageUrl});

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
                  imageUrl ??
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
                angle: -0.07,
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
                  child: Text(
                    'Question ${index + 1} of $total\n$question',
                    style: const TextStyle(height: 1.2, fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
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
