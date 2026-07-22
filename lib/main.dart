import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ShahdShazaApp());
}

/// ألوان التطبيق الأساسية - مبهجة ومناسبة للأطفال
class AppColors {
  static const Color purple = Color(0xFF7B5EF0);
  static const Color pink = Color(0xFFFF6FA5);
  static const Color yellow = Color(0xFFFFC93C);
  static const Color green = Color(0xFF3FC97A);
  static const Color blue = Color(0xFF3EC6FF);
  static const Color background = Color(0xFFFFF7EE);
  static const Color darkText = Color(0xFF3A2E5C);

  static const List<Color> funGradient = [purple, pink];
}

class ShahdShazaApp extends StatelessWidget {
  const ShahdShazaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'شهد وشذى - تعلم الإنجليزية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
        fontFamily: GoogleFonts.baloo2().fontFamily,
        textTheme: GoogleFonts.baloo2TextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
