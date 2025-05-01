import 'package:flutter/material.dart';

class GameInfoWidget extends StatelessWidget {
  final String currentInnings;
  final int playerScore;
  final int botScore;
  final int balls;
  final String message;

  const GameInfoWidget({
    Key? key,
    required this.currentInnings,
    required this.playerScore,
    required this.botScore,
    required this.balls,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          currentInnings,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text("Player Score: $playerScore",
            style: const TextStyle(fontSize: 18, color: Colors.white)),
        Text("Bot Score: $botScore",
            style: const TextStyle(fontSize: 18, color: Colors.white)),
        Text("Ball: ${balls + 1} / 6",
            style: const TextStyle(fontSize: 18, color: Colors.white)),
        const SizedBox(height: 20),
        Text(
          message,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
