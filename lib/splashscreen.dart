import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habits_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('---------->initstate');

    Timer(
        Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HabitsScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white54],
              end: Alignment.bottomRight,
              begin: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Image.asset(
              'images/playstore.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
