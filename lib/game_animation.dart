import 'package:arthum_webview/animation/google_scrachcard/scratch_card.dart';
import 'package:arthum_webview/animation/lottie.dart';
import 'package:arthum_webview/animation/material_dialogs/material_dialogs.dart';
import 'package:arthum_webview/animation/roller_list/roller_list_screen.dart';
import 'package:arthum_webview/animation/spin_wheel/spinWheel.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:reward_popup/reward_popup.dart';

import 'animation/confettie/confettie_screen.dart';
import 'animation/my_review/my_review.dart';
import 'animation/pick_a_card/pick_a_card.dart';

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
                child: Text("Logo")),
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
            ElevatedButton(
                onPressed: () {
                  Get.to(ConfettieScreen());
                },
                child: Text("Confettie View")),
            ElevatedButton(
                onPressed: () {
                  Get.to(MaterialDialogScreen());
                },
                child: Text("Material Dialogs")),
            ElevatedButton(
                onPressed: () {
                  Get.to(PickCardScreen());
                },
                child: Text("Pick a Card")),
            ElevatedButton(
                onPressed: () {
                  Get.to(MyReviewPage());
                },
                child: Text("My Review Page")),
            ElevatedButton(
                onPressed: () async {
                  final answer = await showRewardPopup<String>(
                    context,
                    backgroundColor: Colors.black,
                    child: Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Image.asset(
                          'assets/elephant.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                child: Text("Cool Popup")),
            ElevatedButton(
                onPressed: () async {
                  Get.to(RollerListScreen());
                },
                child: Text("Roller List")),
          ],
        ),
      ),
    );
  }
}
