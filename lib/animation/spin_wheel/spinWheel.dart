import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({super.key});

  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  StreamController<int> selected = StreamController<int>();
  final items = <String>[
    'Vikash',
    'Rahul',
    'Shivani',
    'Radha',
    'Mohit',
    'Avadhesh',
    'Ritu',
    'Adhya',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        setState(() {
          selected.add(
            Fortune.randomInt(0, items.length),
          );
        });
      },
      child: Column(
        children: [
          Expanded(
            child: FortuneWheel(
              selected: selected.stream,
              items: [
                for (var it in items) FortuneItem(child: Text(it)),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
