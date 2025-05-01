import 'package:flutter/material.dart';
import 'game_page.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({super.key});

  void goToGame(BuildContext context, bool isPlayerBattingFirst) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(isPlayerBattingFirst: isPlayerBattingFirst),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png', 
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "What U Want",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => goToGame(context, true),
                  child: const Text("Bat First"),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => goToGame(context, false),
                  child: const Text("Bowl First"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
