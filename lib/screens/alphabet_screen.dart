import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';
import '../data/alphabet_data.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});
  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  final FlutterTts _tts = FlutterTts();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-US');
    _tts.setPitch(1.1);
    _tts.setSpeechRate(0.4);
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = alphabetList[_index];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('الحروف الإنجليزية'),
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => _speak('${item.letter} for ${item.word}'),
                child: Container(
                  key: ValueKey(item.letter),
                  width: 280,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.purple.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10))
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.letter,
                          style: const TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: AppColors.purple)),
                      Text(item.emoji, style: const TextStyle(fontSize: 60)),
                      const SizedBox(height: 8),
                      Text(item.word,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkText)),
                      Text(item.arabicMeaning,
                          style: const TextStyle(
                              fontSize: 20, color: AppColors.pink)),
                      const SizedBox(height: 12),
                      const Icon(Icons.volume_up_rounded,
                          color: AppColors.blue, size: 34),
                    ],
                  ),
                ),
              ).animate(key: ValueKey('anim${item.letter}')).scale(
                  duration: 350.ms, curve: Curves.easeOutBack),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navButton(Icons.arrow_forward_ios, _index > 0, () {
                  setState(() => _index--);
                }),
                Text('${_index + 1} / ${alphabetList.length}',
                    style: const TextStyle(
                        fontSize: 16, color: AppColors.darkText)),
                _navButton(
                    Icons.arrow_back_ios, _index < alphabetList.length - 1,
                    () {
                  setState(() => _index++);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon, bool enabled, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon),
      color: enabled ? AppColors.purple : Colors.grey.shade300,
      iconSize: 30,
      onPressed: enabled ? onTap : null,
    );
  }
}
