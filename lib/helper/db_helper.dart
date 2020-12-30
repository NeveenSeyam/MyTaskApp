import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import '../Models/Data.dart';

class SQL_Helper {
  static SQL_Helper dbHelper;
  static Database _database;

  SQL_Helper._createInstance();

  factory SQL_Helper() {
    if (dbHelper == null) {
      dbHelper = SQL_Helper._createInstance();
    }
    return dbHelper;
  }

  String tableName = "task_table";
  String _id = "id";
  String __title = "title";
  String __checkValue = "checkValue";

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }

  Future<Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "task.db";

    var studentDB =
        await openDatabase(path, version: 2, onCreate: createDatabase);
    return studentDB;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($_id INTEGER PRIMARY KEY AUTOINCREMENT, $__title TEXT, $__checkValue INTEGER )");
  }

  Future<List<Map<String, dynamic>>> getDataMapList() async {
    Database db = await this.database;

    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var result = await db.query(tableName, orderBy: "$_id ASC");
    return result;
  }

  Future<List<Map<String, dynamic>>> getDataMapListCompleted() async {
    Database db = await this.database;

    //var result1 =  await db.rawQuery("SELECT * FROM $tableName ORDER BY $_id ASC");
    var result = await db.query(
      tableName,
      where: "$__checkValue = ?",
    );
    return result;
  }

  Future<int> insertStudent(Data data) async {
    Database db = await this.database;
    var result = await db.insert(tableName, data.toMap());
    return result;
  }

  Future<int> updateStudent(Data data) async {
    Database db = await this.database;
    var result = await db.update(tableName, data.toMap(),
        where: "$_id = ?", whereArgs: [data.id]);
    return result;
  }

  Future<int> deleteStudent(int id) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName WHERE $_id = $id");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all =
        await db.rawQuery("SELECT COUNT (*) FROM $tableName");
    int result = Sqflite.firstIntValue(all);
    return result;
  }

  Future<List<Data>> getTaskList() async {
    var dataMapList = await getDataMapList();
    int count = dataMapList.length;

    List<Data> data = new List<Data>();

    for (int i = 0; i <= count - 1; i++) {
      data.add(Data.getMap(dataMapList[i]));
    }
    return data;
  }

  Future<List<Data>> getTaskListCompleted() async {
    var dataMapList = await getDataMapList();
    int count = dataMapList.length;

    List<Data> students = new List<Data>();

    for (int i = 0; i <= count - 1; i++) {
      students.add(Data.getMap(dataMapList[i]));
    }
    print(students.length);
    final data = students.where((element) => element.checkValue == 1).toList();
    print(data.length);

    return data;
  }

  Future<List<Data>> getTaskListInCompleted() async {
    var dataMapList = await getDataMapList();
    int count = dataMapList.length;

    List<Data> students = new List<Data>();

    for (int i = 0; i <= count - 1; i++) {
      students.add(Data.getMap(dataMapList[i]));
    }
    print(students.length);
    final data = students.where((element) => element.checkValue == 0).toList();
    print(data.length);

    return data;
  }
}
