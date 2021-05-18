import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/DatabaseFile.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/styles/Colors.dart';

class AddTaskScreen extends StatefulWidget {
  final Task todo;
  final Function updateTodoList;
  AddTaskScreen({Key key, this.todo, this.updateTodoList}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  final List<String> _priorities = ['High', 'Medium', 'Low'];

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _title = widget.todo.title;
      _date = widget.todo.date;
      _priority = widget.todo.priority;
    }
    _dateController.text = DateFormat.yMMMMEEEEd().format(_date).toString();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  TextEditingController _dateController = TextEditingController();
  _datePicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2001),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = DateFormat.yMMMMEEEEd().format(_date).toString();
    }
  }

  _delete() {
    DatabaseFile.instance.deleteTodo(widget.todo.id);
    widget.updateTodoList();
    Navigator.pop(context);
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_date, $_priority');

      Task todo = Task(title: _title, date: _date, priority: _priority);
      if (widget.todo == null) {
        todo.status = 0;
        DatabaseFile.instance.insertTodo(todo);
      } else {
        todo.id = widget.todo.id;
        todo.status = widget.todo.status;
        DatabaseFile.instance.updateTodo(todo);
      }
      widget.updateTodoList();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 30.0,
                      color: AppColors.TextColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.todo == null ? 'Add New Task' : 'Update task',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.TextColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // --------- title ----------------
                      TextFormField(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.TextColor,
                          letterSpacing: 0.75,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.SubBgColor,
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.75,
                            color: AppColors.SubTextColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter task title'
                            : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      // ---------- date -----------
                      TextFormField(
                        readOnly: true,
                        controller: _dateController,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.75,
                          color: AppColors.TextColor,
                        ),
                        onTap: _datePicker,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.SubBgColor,
                          hintText: 'Date',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.75,
                            color: AppColors.SubTextColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      // ------------- priority --------------
                      DropdownButtonFormField(
                        isDense: true,
                        dropdownColor: AppColors.BgColor,
                        hint: Text(
                          'Priority',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.75,
                            color: AppColors.SubTextColor,
                          ),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 25.0,
                        ),
                        iconEnabledColor: AppColors.CompleteTaskColor,
                        items: _priorities.map((String priority) {
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(
                              priority,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.TextColor,
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.SubBgColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (input) => _priority == null
                            ? 'Please select priority level'
                            : null,
                        onSaved: (input) => _priority = input,
                        onChanged: (value) {
                          setState(() {
                            _priority = value;
                          });
                        },
                        value: _priority,
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.CompleteTaskColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          child: Text(
                            widget.todo == null ? 'Add Task' : 'Save',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.BgColor,
                              letterSpacing: 0.75,
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),

                      InkWell(
                        child: Container(
                          // margin: EdgeInsets.symmetric(vertical: 30.0),
                          height: 60.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.CompleteTaskColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            widget.todo == null ? 'Cancel' : 'Delete',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.BgColor,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                        onTap: () => widget.todo == null
                            ? Navigator.pop(context)
                            : _delete(),
                      ),
                    ],
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
        ),
      ),
    );
  }
}
