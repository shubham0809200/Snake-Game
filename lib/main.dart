import 'package:flutter/material.dart';
import 'package:snake_game/game/game_stage.dart';
import 'package:snake_game/splash_screen/splash_scree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const GameStage(),
    );
  }
}
