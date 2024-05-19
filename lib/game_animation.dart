import 'package:arthum_webview/animation/google_scrachcard/scratch_card.dart';
import 'package:arthum_webview/animation/lottie.dart';
import 'package:arthum_webview/animation/spin_wheel/spinWheel.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'animation/starMeter/reward_meter.dart';

class GameButtonScreen extends StatefulWidget {
  const GameButtonScreen({super.key});

  @override
  State<GameButtonScreen> createState() => _GameButtonScreenState();
}

class _GameButtonScreenState extends State<GameButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(LottieScreen());
                },
                child: Text("Lottie")),
            ElevatedButton(
                onPressed: () {
                  Get.to(RewardsMeterStars());
                },
                child: Text("Reward Meter")),
            ElevatedButton(
                onPressed: () {
                  Get.to(ScratchCardScreen());
                },
                child: Text("Scratch Card")),
            ElevatedButton(
                onPressed: () {
                  Get.to(SpinWheelScreen());
                },
                child: Text("Spin Wheel")),
          ],
        ),
      ),
    );
  }
}
