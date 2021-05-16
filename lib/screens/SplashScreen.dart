import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/data/Colors.dart';
import 'package:todo_app/screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TODO',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 60.0,
                  fontWeight: FontWeight.w800,
                  color: AppColors.TextColor,
                  letterSpacing: 2,
                  height: 0.5),
            ),
            Text(
              'APP',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: AppColors.TextColor,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: AppColors.BgColor,
          image: DecorationImage(
            image: new AssetImage("assets/images/splashscreen.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
