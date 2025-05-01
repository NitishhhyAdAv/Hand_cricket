import 'package:flutter/material.dart';

class PopupsWidget extends StatelessWidget {
  final bool showSixerImage;
  final bool showOutImage;
  final bool showWinImage;

  const PopupsWidget({
    Key? key,
    required this.showSixerImage,
    required this.showOutImage,
    required this.showWinImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showSixerImage)
          Center(
            child: Image.asset(
              'assets/images/sixer.png',
              width: 220,
              height: 220,
            ),
          ),
        if (showOutImage)
          Center(
            child: Image.asset(
              'assets/images/out.png',
              width: 220,
              height: 220,
            ),
          ),
        if (showWinImage)
          Center(
            child: Image.asset(
              'assets/images/you_won.png',
              width: 220,
              height: 220,
            ),
          ),
      ],
    );
  }
}
