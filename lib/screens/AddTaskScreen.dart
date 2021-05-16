import 'package:flutter/material.dart';
import 'package:todo_app/data/Colors.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: AppColors.BgColor,
        image: DecorationImage(
          image: new AssetImage("assets/images/splashscreen.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
