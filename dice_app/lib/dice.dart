import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() {
    return _Dice();
  }
}

class _Dice extends State<Dice> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(
            "images/dice-1.png",
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 24,
          ),
          Image.asset(
            "images/dice-2.png",
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }
}
