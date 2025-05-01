import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'choose_page.dart';
import 'game_info_widget.dart';
import 'action_buttons_widget.dart';
import 'popups_widget.dart';
import 'countdown_timer_widget.dart';

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
  int secondsLeft = 10;
  Timer? timer;
  bool showSixerImage = false;
  bool showOutImage = false;
  bool showWinImage = false;

  @override
  void initState() {
    super.initState();
    isPlayerBatting = widget.isPlayerBattingFirst;
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft = 10;

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        t.cancel();
        int randomNum = Random().nextInt(6) + 1;
        playTurn(randomNum);
      }
    });
  }

  void showSixerPopup() {
    setState(() {
      showSixerImage = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showSixerImage = false;
        });
      }
    });
  }

  void showOutPopup() {
    setState(() {
      showOutImage = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showOutImage = false;
        });
      }
    });
  }

  void showWinPopup() {
    setState(() {
      showWinImage = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showWinImage = false;
        });
      }
    });
  }

  void playTurn(int playerInput) {
    if (isGameOver) return;

    timer?.cancel();

    int botInput = Random().nextInt(6) + 1;

    setState(() {
      if (isPlayerBatting) {
        if (playerInput == botInput) {
          message = "You are OUT!";
          showOutPopup();
          endInnings();
        } else {
          playerScore += playerInput;
          balls++;
          message = "You scored $playerInput run(s)";
          if (playerInput == 6) showSixerPopup();
          if (balls >= 6) endInnings();
          if (!isFirstInnings && playerScore > botScore) {
            isGameOver = true;
            message = "You Win!";
            showWinPopup();
            return;
          }
        }
      } else {
        if (playerInput == botInput) {
          message = "Bot is OUT!";
          showOutPopup();
          endInnings();
        } else {
          int botRun = botInput;
          botScore += botRun;
          balls++;
          message = "Bot scored $botRun run(s)";
          if (botRun == 6) showSixerPopup();
          if (balls >= 6) endInnings();
          if (!isFirstInnings && botScore > playerScore) {
            isGameOver = true;
            message = "Bot Wins!";
            return;
          }
        }
      }

      if (!isGameOver) startTimer();
    });
  }

  void endInnings() {
    if (isFirstInnings) {
      isFirstInnings = false;
      isPlayerBatting = !isPlayerBatting;
      balls = 0;
      message +=
          "\nInnings Over. Now it's your turn to ${isPlayerBatting ? 'Bat' : 'Bowl'}.";
      startTimer();
    } else {
      isGameOver = true;
      checkWinner();
    }
  }

  void checkWinner() {
    if (playerScore > botScore) {
      message = "You Win!";
      showWinPopup();
    } else if (botScore > playerScore) {
      message = "Bot Wins!";
    } else {
      message = "It's a Tie!";
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          PopupsWidget(
            showSixerImage: showSixerImage,
            showOutImage: showOutImage,
            showWinImage: showWinImage,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                GameInfoWidget(
                  currentInnings: currentInnings,
                  playerScore: playerScore,
                  botScore: botScore,
                  balls: balls,
                  message: message,
                ),
                const Spacer(),
                if (!isGameOver) ...[
                  CountdownTimerWidget(secondsLeft: secondsLeft),
                  ActionButtonsWidget(onNumberTap: playTurn),
                ],
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
}
