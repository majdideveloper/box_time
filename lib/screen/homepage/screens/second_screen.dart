import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/utils/helper_padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _firstGoalController = TextEditingController();
  final TextEditingController _secondGoalController = TextEditingController();
  final TextEditingController _thirdGoalController = TextEditingController();

  @override
  void dispose() {
    _firstGoalController.dispose();
    _secondGoalController.dispose();
    _thirdGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediumPaddingVert,
            Center(
              child: Text(
                "Top Priorities",
              ),
            ),
            mediumPaddingVert,
            Text("First Goal"),
            smallPaddingVert,
            TextField(
              controller: appProvider.firstGoalController,
              maxLength: 70,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // Border around the text field
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            smallPaddingVert,
            Text("Second Goal"),
            smallPaddingVert,
            TextField(
              controller: appProvider.secondGoalController,
              maxLength: 70,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // Border around the text field
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            smallPaddingVert,
            Text("Third Goal"),
            smallPaddingVert,
            TextField(
              controller: appProvider.thirdGoalController,
              maxLength: 70,
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
