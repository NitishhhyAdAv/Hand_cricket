import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  final Function(int) onNumberTap;

  const ActionButtonsWidget({Key? key, required this.onNumberTap}) : super(key: key);

  Widget imageButton(String imagePath, int number) {
    return GestureDetector(
      onTap: () => onNumberTap(number),
      child: Image.asset(
        imagePath,
        width: 70,
        height: 70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageButton('assets/images/one.png', 1),
            const SizedBox(width: 16),
            imageButton('assets/images/two.png', 2),
            const SizedBox(width: 16),
            imageButton('assets/images/three.png', 3),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageButton('assets/images/four.png', 4),
            const SizedBox(width: 16),
            imageButton('assets/images/five.png', 5),
            const SizedBox(width: 16),
            imageButton('assets/images/six.png', 6),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
 