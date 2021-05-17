import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/data/Colors.dart';
import 'package:todo_app/screens/AddTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _todoTask(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Task Title',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: AppColors.TextColor,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 12.0),
          child: Text(
            'Date | Priority',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: AppColors.SubTextColor,
            ),
          ),
        ),
        trailing: Checkbox(
          onChanged: (value) {
            print(value);
          },
          activeColor: AppColors.TaskColor,
          value: true,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.SubBgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Task",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.TextColor,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 7.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 15.0),
                      child: Text(
                        "1 of 10",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.SubTextColor,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return _todoTask(index);
            }),
        decoration: BoxDecoration(
          color: AppColors.BgColor,
          image: DecorationImage(
            image: new AssetImage("assets/images/splashscreen.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.TaskColor,
          elevation: 0,
          child: Icon(
            Icons.add_rounded,
            size: 40.0,
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddTaskScreen())),
        ),
      ),
    );
  }
}
