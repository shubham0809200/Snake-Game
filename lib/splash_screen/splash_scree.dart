import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/game/game_stage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TextLiquidFill(
        text: 'SNAKES',
        waveColor: Colors.white,
        boxBackgroundColor: Colors.black,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 80.0,
          fontWeight: FontWeight.bold,
        ),
        boxHeight: MediaQuery.of(context).size.height,
      ),
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 6), (_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const GameStage(),
        ),
      );
    });
  }
}
