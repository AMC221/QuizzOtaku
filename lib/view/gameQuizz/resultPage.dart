import 'package:flutter/material.dart';
import 'package:quizzflutter/view/homepage.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultPage({required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    bool isGoodResult = correctAnswers >= totalQuestions / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résultats du Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isGoodResult ? Icons.thumb_up : Icons.thumb_down,
              size: 80,
              color: isGoodResult ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 16.0),
            Text(
              "Vous avez obtenu $correctAnswers sur $totalQuestions !",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: isGoodResult ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextButton(
                onPressed: () {
                  // Navigate back to the home screen when the user taps the button
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                        (route) => false,
                  );
                },
                child: const Text(
                  "Retour à l'accueil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
