import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';
import '../data/alphabet_data.dart';

class WordMatchGame extends StatefulWidget {
  const WordMatchGame({super.key});
  @override
  State<WordMatchGame> createState() => _WordMatchGameState();
}

class _WordMatchGameState extends State<WordMatchGame> {
  final FlutterTts _tts = FlutterTts();
  late ConfettiController _confetti;
  late LetterItem _target;
  late List<LetterItem> _options;
  int _score = 0;
  int _round = 1;
  String? _feedback;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 1));
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.4);
    _newRound();
  }

  void _newRound() {
    final rand = Random();
    final shuffled = List<LetterItem>.from(alphabetList)..shuffle(rand);
    _target = shuffled.first;
    _options = shuffled.take(4).toList()..shuffle(rand);
    _feedback = null;
    Future.delayed(const Duration(milliseconds: 300),
        () => _tts.speak(_target.word));
    setState(() {});
  }

  void _onChoice(LetterItem choice) {
    final correct = choice.word == _target.word;
    setState(() {
      _feedback = correct ? 'أحسنت! 🎉' : 'حاول مرة أخرى 💪';
      if (correct) {
        _score += 10;
        _confetti.play();
      }
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (correct) {
        _round++;
        _newRound();
      } else {
        setState(() => _feedback = null);
      }
    });
  }

  @override
  void dispose() {
    _tts.stop();
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('لعبة المطابقة | النقاط: $_score'),
        backgroundColor: AppColors.pink,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _tts.speak(_target.word),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text('استمع واختر الصورة الصحيحة',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      const SizedBox(height: 6),
                      Text(_target.word,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      const Icon(Icons.volume_up_rounded,
                          color: Colors.white, size: 30),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _options.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, i) {
                    final opt = _options[i];
                    return GestureDetector(
                      onTap: () => _onChoice(opt),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 4))
                          ],
                        ),
                        child: Center(
                          child: Text(opt.emoji,
                              style: const TextStyle(fontSize: 60)),
                        ),
                      ),
                    ).animate().fadeIn(delay: (80 * i).ms).scale();
                  },
                ),
              ),
              if (_feedback != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_feedback!,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.green)),
                ).animate().fadeIn().shake(),
              const SizedBox(height: 10),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
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
}
