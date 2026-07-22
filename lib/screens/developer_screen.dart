import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('عن المطور'),
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.purple, width: 4),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.purple.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8))
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/hakim.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 20),
            const Text(
              'المهندس : حكيم شاكر',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 8),
            const Text(
              'مطور تطبيق شهد وشذى 💜',
              style: TextStyle(fontSize: 16, color: AppColors.pink),
            ).animate().fadeIn(delay: 350.ms),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'هذا التطبيق صُنع بكل حب كهدية جميلة، ليكون رفيقاً ممتعاً في تعلم اللغة الإنجليزية.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.darkText),
              ),
            ).animate().fadeIn(delay: 500.ms),
          ],
        ),
      ),
    );
  }
}
