import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  int numberOfSquares = 760;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  void generateNewFood() {
    food = randomNumber.nextInt(700);
    noFoodInsideSnake(food);
  }

  noFoodInsideSnake(int s) {
    for (int i = 0; i < snakePosition.length; i++) {
      if (snakePosition[i] != s) {
        return generateNewFood();
      }
    }
  }

  void startGame() {
    snakePosition = [45, 65, 85, 105, 125];
    const duration = Duration(milliseconds: 200);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

  var direction = 'down';
  void updateSnake() {
    setState(
      () {
        switch (direction) {
          case ('down'):
            if (snakePosition.last > 740) {
              snakePosition.add(snakePosition.last + 20 - 760);
            } else {
              snakePosition.add(snakePosition.last + 20);
            }
            break;

          case ('up'):
            if (snakePosition.last < 20) {
              snakePosition.add(snakePosition.last - 20 + 760);
            } else {
              snakePosition.add(snakePosition.last - 20);
            }

            break;
          case ('left'):
            if (snakePosition.last % 20 == 0) {
              snakePosition.add(snakePosition.last - 1 + 20);
            } else {
              snakePosition.add(snakePosition.last - 1);
            }
            break;

          case ('right'):
            if ((snakePosition.last + 1) % 20 == 0) {
              snakePosition.add(snakePosition.last + 1 - 20);
            } else {
              snakePosition.add(snakePosition.last + 1);
            }
            break;

          default:
        }

        if (snakePosition.last == food) {
          generateNewFood();
        } else {
          snakePosition.removeAt(0);
        }
      },
    );
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; i < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content:
              Text('You\'re  score: ' + (snakePosition.length - 5).toString()),
          actions: [
            TextButton(
              onPressed: () {
                startGame();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20),
                itemBuilder: (BuildContext context, int index) {
                  if (snakePosition.contains(index)) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == food) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.grey[900],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 5.0, left: 20.0, right: 20.0, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: startGame,
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 20, right: 20, bottom: 5),
                      child: Text(
                        's t a r t',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "score : " + (snakePosition.length - 5).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
