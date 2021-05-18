import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/TodoModel.dart';

class DatabaseFile {
  static final DatabaseFile instance = DatabaseFile._instance();
  static Database _db;

  DatabaseFile._instance();

  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    print(dir.toString());
    String path = dir.path + 'todo.db';
    final todoDb = await openDatabase(path, version: 1, onCreate: createDb);
    return todoDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(todoTable);
    return result;
  }

  Future<List<Task>> getTodoList() async {
    final List<Map<String, dynamic>> todoMapList = await getTodoMapList();
    final List<Task> todoList = [];
    todoMapList.forEach((taskMap) {
      todoList.add(Task.fromMap(taskMap));
    });
    todoList.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    return todoList;
  }

  Future<int> insertTodo(Task todo) async {
    Database db = await this.db;
    final int result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  Future<int> updateTodo(Task todo) async {
    Database db = await this.db;
    final int result = await db.update(
      todoTable,
      todo.toMap(),
      where: '$colId = ?',
      whereArgs: [todo.id],
    );
    return result;
  }

  Future<int> deleteTodo(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      todoTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
