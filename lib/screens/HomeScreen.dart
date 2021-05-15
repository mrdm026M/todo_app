import 'package:flutter/material.dart';
import 'package:todo_app/data/Colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
