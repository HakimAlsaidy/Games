import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';
import '../data/alphabet_data.dart';

class QuizGame extends StatefulWidget {
  const QuizGame({super.key});
  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  late ConfettiController _confetti;
  int _score = 0;
  int _questionIndex = 0;
  late List<LetterItem> _quizItems;
  late LetterItem _current;
  late List<String> _choices;
  bool _finished = false;

  static const int totalQuestions = 8;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 1));
    final shuffled = List<LetterItem>.from(alphabetList)..shuffle();
    _quizItems = shuffled.take(totalQuestions).toList();
    _loadQuestion();
  }

  void _loadQuestion() {
    _current = _quizItems[_questionIndex];
    final rand = Random();
    final wrongPool = alphabetList
        .where((e) => e.arabicMeaning != _current.arabicMeaning)
        .toList()
      ..shuffle(rand);
    _choices = [
      _current.arabicMeaning,
      ...wrongPool.take(2).map((e) => e.arabicMeaning),
    ]..shuffle(rand);
    setState(() {});
  }

  void _answer(String choice) {
    final correct = choice == _current.arabicMeaning;
    if (correct) {
      _score++;
      _confetti.play();
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_questionIndex < totalQuestions - 1) {
        setState(() => _questionIndex++);
        _loadQuestion();
      } else {
        setState(() => _finished = true);
      }
    });
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('اختبار ممتع'),
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Center(
            child: _finished ? _buildResult() : _buildQuestion(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 25,
              colors: const [
                AppColors.purple,
                AppColors.pink,
                AppColors.yellow,
                AppColors.green
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('السؤال ${_questionIndex + 1} من $totalQuestions',
              style: const TextStyle(fontSize: 16, color: AppColors.darkText)),
          const SizedBox(height: 16),
          Text(_current.emoji, style: const TextStyle(fontSize: 90)),
          Text(_current.word,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple)),
          const SizedBox(height: 8),
          const Text('ما معنى هذه الكلمة؟',
              style: TextStyle(fontSize: 18, color: AppColors.darkText)),
          const SizedBox(height: 24),
          ..._choices.map((c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => _answer(c),
                    child: Text(c, style: const TextStyle(fontSize: 18)),
                  ),
                ),
              )),
        ],
      ),
    ).animate(key: ValueKey(_questionIndex)).fadeIn().slideX(begin: 0.1);
  }

  Widget _buildResult() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🏆', style: TextStyle(fontSize: 90)),
        const SizedBox(height: 12),
        Text('نتيجتك: $_score من $totalQuestions',
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText)),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('رجوع للقائمة',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    ).animate().scale();
  }
}
