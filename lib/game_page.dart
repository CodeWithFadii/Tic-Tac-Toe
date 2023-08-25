import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  bool playerA = false;
  bool gameOver = false;
  List<int> aList = [];
  List<int> bList = [];
  List<int> allList = [];
  int player1Score = 0;
  int player2Score = 0;
  List<List<int>> answersList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  restartGame() {
    allList.clear();
    aList.clear();
    bList.clear();
    gameOver = false;
  }

  AlertDialog dialog(String text) => AlertDialog.adaptive(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            const Text(
              'Congratulations🎉',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(height: 14),
            Text(
              'Player $text Wins',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                restartGame();
                playerA ? playerA = false : playerA = true;
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text(
                'Restart Game',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Player 1 score :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$player1Score',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Player 2 score :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$player2Score',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                //if playerA is not true means PalyerA turns
                //otherwise if playerA true means player b turns
                !playerA ? "Player '1' Turn" : "Player '2' Turn"),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        //if user taps the fields that already selected then
                        //no need to change the users turn
                        if (!gameOver) {
                          !allList.contains(index)
                              ? playerA
                                  ? playerA = false
                                  : playerA = true
                              : allList;
                        }
                      });
                      //if user taps to empty field then add to list
                      //otherwise no need to add
                      if (!gameOver) {
                        !allList.contains(index) ? allList.add(index) : allList;
                      }
                      //if it's playerA turn then chack if the box is already selected by
                      //the any player or not, if not then add to aList of playerA
                      playerA
                          ? !aList.contains(index) && !bList.contains(index)
                              ? aList.add(index)
                              : aList
                          //if it's playerB turn then chack if the box is already selected by
                          //the any player or not, if not then add to bList of playerB
                          : !bList.contains(index) && !aList.contains(index)
                              ? bList.add(index)
                              : bList;
                      // Check if all elements in aList are present in any list in answersList
                      if (!gameOver) {
                        if (answersList.any((list) =>
                            list.every((element) => aList.contains(element)))) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return dialog('1');
                            },
                          );
                          setState(() {
                            player1Score++;
                            gameOver = true;
                          });
                        }
                        // Check if all elements in bList are present in any list in answersList
                        if (answersList.any((list) =>
                            list.every((element) => bList.contains(element)))) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return dialog('2');
                            },
                          );
                          setState(() {
                            player2Score++;
                            gameOver = true;
                          });
                        }
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                      child: allList.contains(index)
                          ? Center(
                              child: Icon(
                                  aList.contains(index)
                                      ? Icons.circle_outlined
                                      : Icons.cancel_outlined,
                                  size: 60,
                                  color: aList.contains(index)
                                      ? Colors.amber
                                      : Colors.black),
                            )
                          : const Center(),
                    ),
                  );
                },
              ),
            ),
            MaterialButton(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              minWidth: 200,
              onPressed: () {
                restartGame();
                playerA ? playerA = false : playerA = true;
                setState(() {});
              },
              height: 50,
              child: const Text(
                'Restart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Created by Fadi-Flutter',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
