import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snake_game/game/game.dart';

class GameStage extends StatelessWidget {
  const GameStage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: _height * 0.4,
            color: Colors.grey[900],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _level(context, 300, "Easy"),
                _level(context, 200, "Medium"),
                _level(context, 100, "Hard"),
              ],
            ),
          )
        ],
      ),
    );
  }

  _level(BuildContext context, int _speed, String levelName) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Game(speed: _speed),
          ),
        );
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            levelName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              letterSpacing: 5,
            ),
          ),
        ),
      ),
    );
  }
}
