import 'dart:math';
import 'package:flutter/material.dart';
import 'choose_page.dart'; // Make sure you have this file in your project

class GamePage extends StatefulWidget {
  final bool isPlayerBattingFirst;

  const GamePage({super.key, required this.isPlayerBattingFirst});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int playerScore = 0;
  int botScore = 0;
  int balls = 0;
  bool isPlayerBatting = true;
  bool isFirstInnings = true;
  bool isGameOver = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    isPlayerBatting = widget.isPlayerBattingFirst;
  }

  void playTurn(int playerInput) {
    if (isGameOver) return;

    int botInput = Random().nextInt(6) + 1;

    setState(() {
      if (isPlayerBatting) {
        if (playerInput == botInput) {
          message = "You are OUT!";
          endInnings();
        } else {
          playerScore += playerInput;
          balls++;
          message = "You scored $playerInput run(s)";
          if (balls >= 6) endInnings();
          if (!isFirstInnings && playerScore > botScore) {
            isGameOver = true;
            message = "You Win!";
          }
        }
      } else {
        if (playerInput == botInput) {
          message = "Bot is OUT!";
          endInnings();
        } else {
          int botRun = botInput;
          botScore += botRun;
          balls++;
          message = "Bot scored $botRun run(s)";
          if (balls >= 6) endInnings();
          if (!isFirstInnings && botScore > playerScore) {
            isGameOver = true;
            message = "Bot Wins!";
          }
        }
      }
    });
  }

  void endInnings() {
    if (isFirstInnings) {
      isFirstInnings = false;
      isPlayerBatting = !isPlayerBatting;
      balls = 0;
      message += "\nInnings Over. Now it's your turn to ${isPlayerBatting ? 'Bat' : 'Bowl'}.";
    } else {
      isGameOver = true;
      checkWinner();
    }
  }

  void checkWinner() {
    if (playerScore > botScore) {
      message = "You Win!";
    } else if (botScore > playerScore) {
      message = "Bot Wins!";
    } else {
      message = "It's a Tie!";
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentInnings = isGameOver
        ? 'Game Over'
        : isPlayerBatting
            ? 'You are Batting'
            : 'You are Bowling';

    return Scaffold(
      
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.png', // update filename if needed
            fit: BoxFit.cover,
          ),

          // Game content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currentInnings,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(height: 16),
                Text("Player Score: $playerScore",
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
                Text("Bot Score: $botScore",
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
                Text("Ball: ${balls + 1} / 6",
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(height: 20),
                Text(message,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center),
                const SizedBox(height: 30),
                if (!isGameOver) buildNumberButtons(),
                if (isGameOver)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const ChoosePage()),
                        (route) => false,
                      );
                    },
                    child: const Text("Play Again"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumberButtons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(6, (index) {
        int number = index + 1;
        return ElevatedButton(
          onPressed: () => playTurn(number),
          child: Text(number.toString(), style: const TextStyle(fontSize: 18)),
        );
      }),
    );
  }
}
