import 'package:flutter/cupertino.dart';
import '../Models/Data.dart';
import '../helper/db_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Data> _task = [];
  List<Data> _taskCompleted = [];
  List<Data> _taskInCompleted = [];
  SQL_Helper helper = new SQL_Helper();

  List<Data> get task {
    return [..._task];
  }

  List<Data> get taskCompleted {
    return [..._taskCompleted];
  }

  List<Data> get taskInCompleted {
    return [..._taskInCompleted];
  }

  Future<void> addTask(String title, int checkVale) async {
    notifyListeners();

    int result;
    result = await helper.insertStudent(Data(title, checkVale));

    if (result == 0) {
      print("Task not saved");
    } else {
      print("Task  saved");
    }
  }

  Future<void> fetchAndSetAllTasks() async {
    final dataList = await helper.getTaskList();
    print(dataList.length);
    //  _task.addAll(dataList);
    _task = dataList
        .map(
          (task) => Data.withId(
            task.id,
            task.title,
            task.checkValue,
          ),
        )
        .toList();
    //  final data = helper.getTaskList();

    notifyListeners();
  }

  Future<List<Data>> fetchAndSetCompletedTasks() async {
    final dataList = await helper.getTaskListCompleted();
    print(dataList.length);
    //  _task.addAll(dataList);
    _taskCompleted = dataList
        .map(
          (task) => Data.withId(
            task.id,
            task.title,
            task.checkValue,
          ),
        )
        .toList();
    //  final data = helper.getTaskList();

    notifyListeners();

    //  return _task.where((element) => element.checkValue == 1);
  }

  Future<List<Data>> fetchAndSetInCompletedTasks() async {
    final dataList = await helper.getTaskListInCompleted();
    print(dataList.length);
    //  _task.addAll(dataList);
    _taskInCompleted = dataList
        .map(
          (task) => Data.withId(
            task.id,
            task.title,
            task.checkValue,
          ),
        )
        .toList();
    //  final data = helper.getTaskList();

    notifyListeners();

    //  return _task.where((element) => element.checkValue == 1);
  }

  Future<void> deletTask(Data data) async {
    int ressult = await helper.deleteStudent(data.id);
    _task.removeWhere((element) => element.id == data.id);
    if (ressult != 0) {
      notifyListeners();
    } else {
      print("Someting wrong happen ");
    }
  }

  Future<void> updateTask(Data data) async {
    int result;
    result = await helper.updateStudent(data);
    if (result == 0) {
      print("task not saved");
      notifyListeners();
    } else {
      print('task  has been saved successfully');
    }
  }
}
