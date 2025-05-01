import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatelessWidget {
  final int secondsLeft;

  const CountdownTimerWidget({Key? key, required this.secondsLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: secondsLeft / 10,
                strokeWidth: 6,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation(Colors.redAccent),
              ),
              Text(
                '$secondsLeft',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Pick a number before time runs out!",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
