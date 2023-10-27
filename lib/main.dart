import 'package:box_time/screen/liquid_swipe_screen/liquid_swipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:box_time/provider/app_provider.dart';
import 'package:box_time/screen/homepage/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if it's the first time the app is opened
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));

  if (isFirstTime) {
    // If it's the first time, set the flag to false
    await prefs.setBool('isFirstTime', false);
  }
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({
    Key? key,
    required this.isFirstTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return AppProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Box Time',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            LiquidSwipeScreen(), // isFirstTime ? LiquidSwipeScreen() : const HomePage(),
      ),
    );
  }

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;
    if (isFirstTime) {
      // If it's the first time, set the flag to false
      await prefs.setBool('first_time', false);
    }
    return isFirstTime;
  }
}
