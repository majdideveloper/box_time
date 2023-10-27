import 'package:box_time/screen/homepage/homepage.dart';
import 'package:box_time/utils/helper_padding.dart';
import 'package:flutter/material.dart';

class LiquidSwipeScreen extends StatelessWidget {
  LiquidSwipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          largePaddingVert,
          Center(
            child: Image.asset(
              "assets/logo2.png",
            ),
          ),
          const Center(
            child: Text(
              "Box Time",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          smallPaddingVert,
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Transform your day: Brain Dump, Prioritize, and Schedule with Box Time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const HomePage(); // Replace with the destination screen/widget.
                  }),
                  (Route<dynamic> route) =>
                      false, // This condition removes all previous routes.
                );
              },
              child: const Text("Let's Go")),
        ],
      ),
    ));
  }
}
