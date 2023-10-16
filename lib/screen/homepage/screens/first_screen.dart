import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/utils/helper_padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Brain Dump",
            ),
            mediumPaddingVert,
            TextField(
              controller: appProvider.ideaDayController,
              maxLength: 550,
              maxLines: 20,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // Border around the text field
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
