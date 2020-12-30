import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Data.dart';
import '../provider/task_provider.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  Data updateData;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<TaskProvider>(context, listen: false);

    return FutureBuilder(
      future: Provider.of<TaskProvider>(context, listen: false)
          .fetchAndSetAllTasks(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<TaskProvider>(
                  child: Center(
                    child: const Text('Got no Task yet, start adding some!'),
                  ),
                  builder: (ctx, data, ch) => data.task.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: data.task.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                //     _delete(context, data.task[i]);
                                providerData.deletTask(data.task[i]);
                              },
                            ),
                            trailing: Checkbox(
                              activeColor: Colors.blue,
                              value: checkValue(
                                data.task[i].checkValue,
                              ),
                              onChanged: (bool value) {
                                updateData = data.task[i];

                                int checkvalueonChage = value == true ? 1 : 0;

                                updateData.checkValue = checkvalueonChage;
                                setState(() {
                                  //      update(updateData);
                                  providerData.updateTask(updateData);
                                });
                              },
                            ),
                            title: Text(data.task[i].title),
                          ),
                        ),
                ),
    );
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
