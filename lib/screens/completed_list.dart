import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/Data.dart';
import '../helper/db_helper.dart';

class CompletedList extends StatefulWidget {
  @override
  _CompletedListState createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  SQL_Helper helper = new SQL_Helper();
  List<Data> dataList;
  int count = 0;
  Data updateData;
  bool flag = false;
  bool checkOnChangeValue;
  void lisenertoUpdataListBilder() {
    final Future<Database> db = helper.initializedDatabase();
    db.then((database) {
      Future<List<Data>> data = helper.getTaskListCompleted();
      data.then((theList) {
        setState(() {
          this.dataList = theList;
          this.count = theList.length;
        });
      });
    });
  }

  void _deleteTaskWithSameId(Data data) async {
    int ressult = await helper.deleteTaskData(data.id);
    if (ressult != 0) {
      lisenertoUpdataListBilder();
    }
  }

  void updateTaskWithSameId(Data data) async {
    await helper.updateTaskData(data);
  }

  @override
  Widget build(BuildContext context) {
    if (dataList == null) {
      dataList = new List<Data>();
      lisenertoUpdataListBilder();
    }

    return getdataList();
  }

  ListView getdataList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  _deleteTaskWithSameId(this.dataList[position]);
                },
              ),
              trailing: Checkbox(
                activeColor: Colors.blue,
                value: checkValue(
                  this.dataList[position].checkValue,
                ),
                onChanged: (bool value) {
                  updateData = dataList[position];

                  int checkvalueonChage = value == true ? 1 : 0;

                  updateData.checkValue = checkvalueonChage;
                  setState(() {
                    updateTaskWithSameId(updateData);
                  });
                },
              ),
              title: Text(this.dataList[position].title),
            ),
          );
        });
  }

  bool checkValue(int value) {
    switch (value) {
      case 1:
        return true;
        break;
      case 0:
        return false;
        break;
    }
  }
}
