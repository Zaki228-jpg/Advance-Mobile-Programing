import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roll Dice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDice = 1;
  int rightDice = 1;

  final Random random = Random();

  void rollLeftDice() {
    setState(() {
      leftDice = random.nextInt(6) + 1;
    });
  }

  void rollRightDice() {
    setState(() {
      rightDice = random.nextInt(6) + 1;
    });
  }

  void rollBothDice() {
    setState(() {
      leftDice = random.nextInt(6) + 1;
      rightDice = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Roll Dice',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap a dice to roll it',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: rollLeftDice,
                  child: Image.asset(
                    'assets/images/dice$leftDice.png',
                    width: 130,
                    height: 130,
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: rollRightDice,
                  child: Image.asset(
                    'assets/images/dice$rightDice.png',
                    width: 130,
                    height: 130,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Total: ${leftDice + rightDice}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: rollBothDice,
              child: const Text(
                'ROLL BOTH',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
