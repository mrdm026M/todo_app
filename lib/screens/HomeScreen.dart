import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/DatabaseFile.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/screens/AddTaskScreen.dart';
import 'package:todo_app/styles/Colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Task>> _todoList;

  @override
  void initState() {
    super.initState();
    _updateTodoList();
  }

  _updateTodoList() {
    setState(() {
      _todoList = DatabaseFile.instance.getTodoList();
    });
  }

  Widget _todoTask(Task todo) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            todo.title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 21.25,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: AppColors.TextColor,
              decoration: todo.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 5.0),
          child: Text(
            '${DateFormat.yMMMMEEEEd().format(todo.date).toString()} | ${todo.priority}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 11.25,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: AppColors.SubTextColor,
              decoration: todo.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
        ),
        trailing: Checkbox(
          onChanged: (value) {
            todo.status = value ? 1 : 0;
            DatabaseFile.instance.updateTodo(todo);
            _updateTodoList();
          },
          activeColor: AppColors.TaskColor,
          value: todo.status == 1 ? true : false,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddTaskScreen(
              updateTodoList: _updateTodoList,
              todo: todo,
            ),
          ),
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
        child: FutureBuilder(
          future: _todoList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final int completedTodoCount = snapshot.data
                .where((Task todo) => todo.status == 1)
                .toList()
                .length;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              itemCount: 1 + snapshot.data.length,
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
                          "$completedTodoCount out of ${snapshot.data.length} - Completed",
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
                return _todoTask(snapshot.data[index - 1]);
              },
            );
          },
        ),
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
              builder: (BuildContext context) => AddTaskScreen(
                updateTodoList: _updateTodoList,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
