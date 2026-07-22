import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';
import 'alphabet_screen.dart';
import 'word_match_game.dart';
import 'quiz_game.dart';
import 'developer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem('الحروف الإنجليزية', '🔤', AppColors.purple,
          (ctx) => const AlphabetScreen()),
      _MenuItem('لعبة مطابقة الكلمات', '🧩', AppColors.pink,
          (ctx) => const WordMatchGame()),
      _MenuItem('اختبار ممتع', '🎯', AppColors.green,
          (ctx) => const QuizGame()),
      _MenuItem('عن المطور', '👨‍💻', AppColors.blue,
          (ctx) => const DeveloperScreen()),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              const Text('أهلاً بك! 👋',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText))
                  .animate()
                  .fadeIn(),
              const SizedBox(height: 4),
              const Text('اختر لعبة وابدأ التعلم بالمرح',
                  style: TextStyle(fontSize: 16, color: AppColors.darkText)),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _MenuCard(item: item)
                        .animate()
                        .fadeIn(delay: (100 * index).ms)
                        .slideY(begin: 0.2, end: 0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String emoji;
  final Color color;
  final Widget Function(BuildContext) builder;
  _MenuItem(this.title, this.emoji, this.color, this.builder);
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: item.builder));
        },
        child: Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: item.color.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 50)),
              const SizedBox(height: 12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
