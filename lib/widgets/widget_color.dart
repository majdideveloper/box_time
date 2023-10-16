import 'package:box_time/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:box_time/provider/app_provider.dart';

class WidgetColor extends StatelessWidget {
  Color? colorBox;
  WidgetColor({
    Key? key,
    this.colorBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                appProvider.setColor = colorGreen;
              },
              child: CircleAvatar(
                backgroundColor: colorGreen,
                child: colorBox != colorGreen ? const SizedBox() : Text("✓"),
              ),
            ),
            GestureDetector(
              onTap: () {
                appProvider.setColor = colorBlue;
              },
              child: CircleAvatar(
                backgroundColor: colorBlue,
                child: colorBox != colorBlue ? const SizedBox() : Text("✓"),
              ),
            ),
            GestureDetector(
              onTap: () {
                appProvider.setColor = colorRed;
              },
              child: CircleAvatar(
                backgroundColor: colorRed,
                child: colorBox != colorRed ? const SizedBox() : Text("✓"),
              ),
            ),
          ],
        );
      },
    );
  }
}
