import 'package:box_time/screen/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class LiquidSwipeScreen extends StatelessWidget {
  LiquidSwipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        slideIconWidget: const Icon(
          Icons.arrow_back_ios,
          size: 40,
        ),
        positionSlideIcon: 0.5,
        waveType: WaveType.circularReveal,
        enableLoop: false,
        onPageChangeCallback: (activePageIndex) {
          if (activePageIndex == 2) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          }
        },
      ),
    );
  }

  final List<Widget> pages = [
    Container(
      color: Colors.amber,
      child: Image.asset("assets/slider1.png"),
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.redAccent,
    ),
  ];
}
