import 'package:flutter/material.dart';
import 'package:tic_tac_game/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Franklin',
        useMaterial3: true,
      ),
      home: const TicTacToeScreen(),
    );
  }
}
