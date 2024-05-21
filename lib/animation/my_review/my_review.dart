import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

import 'ArcChooser.dart';
import 'SmilePainter.dart';

class MyReviewPage extends StatefulWidget {
  MyReviewPage({Key? key}) : super(key: key);

  @override
  _MyReviewPageState createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage>
    with TickerProviderStateMixin {
  final PageController pageControl = PageController(
    initialPage: 2,
    keepPage: false,
    viewportFraction: 0.2,
  );

  int slideValue = 200;
  int lastAnimPosition = 2;

  late AnimationController animation;

  List<ArcItem> arcItems = [];

  late ArcItem badArcItem;
  late ArcItem ughArcItem;
  late ArcItem okArcItem;
  late ArcItem goodArcItem;

  late Color startColor;
  late Color endColor;

  @override
  void initState() {
    super.initState();

    badArcItem = ArcItem("BAD", [Color(0xFFfe0944), Color(0xFFfeae96)], 0.0);
    ughArcItem = ArcItem("UGH", [Color(0xFFF9D976), Color(0xfff39f86)], 0.0);
    okArcItem = ArcItem("OK", [Color(0xFF21e1fa), Color(0xff3bb8fd)], 0.0);
    goodArcItem = ArcItem("GOOD", [Color(0xFF3ee98a), Color(0xFF41f7c7)], 0.0);

    arcItems.add(badArcItem);
    arcItems.add(ughArcItem);
    arcItems.add(okArcItem);
    arcItems.add(goodArcItem);

    startColor = Color(0xFF21e1fa);
    endColor = Color(0xff3bb8fd);

    animation = AnimationController(
      value: 0.0,
      lowerBound: 0.0,
      upperBound: 400.0,
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
        setState(() {
          slideValue = animation.value.toInt();

          double ratio;

          if (slideValue <= 100) {
            ratio = animation.value / 100;
            startColor =
                Color.lerp(badArcItem.colors[0], ughArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(badArcItem.colors[1], ughArcItem.colors[1], ratio)!;
          } else if (slideValue <= 200) {
            ratio = (animation.value - 100) / 100;
            startColor =
                Color.lerp(ughArcItem.colors[0], okArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(ughArcItem.colors[1], okArcItem.colors[1], ratio)!;
          } else if (slideValue <= 300) {
            ratio = (animation.value - 200) / 100;
            startColor =
                Color.lerp(okArcItem.colors[0], goodArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(okArcItem.colors[1], goodArcItem.colors[1], ratio)!;
          } else if (slideValue <= 400) {
            ratio = (animation.value - 300) / 100;
            startColor =
                Color.lerp(goodArcItem.colors[0], badArcItem.colors[0], ratio)!;
            endColor =
                Color.lerp(goodArcItem.colors[1], badArcItem.colors[1], ratio)!;
          }
        });
      });

    animation.animateTo(slideValue.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        color: Colors.white, fontSize: 24.00, fontWeight: FontWeight.bold);

    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "How was your experience with us?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width / 2) + 60),
              painter: SmilePainter(slideValue),
            ),
            //          Slider(
            //            min: 0.0,
            //            max: 400.0,
            //            value: slideValue.toDouble(),
            //            onChanged: (double newValue) {
            //              setState(() {
            //                slideValue = newValue.round();
            //              });
            //            },
            //          ),

            //           SizedBox(
            //            height: 50.0,
            //            child:  NotificationListener(
            //              onNotification: (ScrollNotification notification){
            //                if(!notification.metrics.atEdge){
            //                  print('_MyReviewPageState.build ' + MediaQuery.of(context).size.width.toString() + " " + notification.metrics.pixels.toString());
            //                }
            //
            //              },
            //              child: PageView.builder(
            //                pageSnapping: true,
            //                onPageChanged: (int value) {
            //                  print('_MyReviewPageState._onPageChanged ' + value.toString());
            //                  animation.animateTo(value*100.0);
            //                },
            //                controller: pageControl,
            //                itemCount: arcItems.length,
            //                physics:  AlwaysScrollableScrollPhysics(),
            //                itemBuilder: (context, index) {
            //                  return  Container(
            //                      decoration:  BoxDecoration(
            //                        gradient:  LinearGradient(
            //                            colors: [
            //                              arcItems[index].colors[0],
            //                              arcItems[index].colors[1]
            //                            ]
            //                        ),
            //                      ),
            //                      alignment: Alignment.center,
            //                      child:  Text(
            //                        arcItems[index].text,
            //                        style: textStyle,
            //                      ));
            //                },
            //              ),
            //            ),
            //          ),
            Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  ArcChooser()
                    ..arcSelectedCallback = (int pos, ArcItem item) {
                      int animPosition = pos - 2;
                      if (animPosition > 3) {
                        animPosition = animPosition - 4;
                      }

                      if (animPosition < 0) {
                        animPosition = 4 + animPosition;
                      }

                      if (lastAnimPosition == 3 && animPosition == 0) {
                        animation.animateTo(4 * 100.0);
                      } else if (lastAnimPosition == 0 && animPosition == 3) {
                        animation.forward(from: 4 * 100.0);
                        animation.animateTo(animPosition * 100.0);
                      } else if (lastAnimPosition == 0 && animPosition == 1) {
                        animation.forward(from: 0.0);
                        animation.animateTo(animPosition * 100.0);
                      } else {
                        animation.animateTo(animPosition * 100.0);
                      }

                      lastAnimPosition = animPosition;
                    },
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      elevation: 8.0,
                      child: Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: [startColor, endColor]),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'SUBMIT',
                            style: textStyle,
                          )),
                    ),
                    //              child: RaisedButton(
                    //                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    //                child: Text('SUBMIT'),
                    //                onPressed: () {
                    //                  print('cool');
                    //                },
                    //              ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
