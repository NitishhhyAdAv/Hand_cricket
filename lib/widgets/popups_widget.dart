import 'package:flutter/material.dart';

class PopupsWidget extends StatelessWidget {
  final bool showSixerImage;
  final bool showOutImage;

  const PopupsWidget({
    Key? key,
    required this.showSixerImage,
    required this.showOutImage,
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
      ],
    );
  }
}
