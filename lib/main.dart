import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import './screens/tabs_screan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splash: Image.asset(
            'assets/taskImg.jpg',
            width: 500,
            height: 500,
          ),
          splashIconSize: 350,
          nextScreen: TabsScreen(),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.white,
          duration: 1000,
        ));
  }
}
