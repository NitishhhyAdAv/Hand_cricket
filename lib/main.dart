import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const HandCricketApp());
}

class HandCricketApp extends StatelessWidget {
  const HandCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Cricket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
