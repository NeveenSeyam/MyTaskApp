import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Data.dart';
import '../provider/task_provider.dart';

class IncompletedList extends StatefulWidget {
  @override
  _IncompletedListState createState() => _IncompletedListState();
}

class _IncompletedListState extends State<IncompletedList> {
  Data updateData;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<TaskProvider>(context, listen: false);

    return FutureBuilder(
      future: Provider.of<TaskProvider>(context, listen: false)
          .fetchAndSetInCompletedTasks(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<TaskProvider>(
                  child: Center(
                    child: const Text('Got no Task yet, start adding some!'),
                  ),
                  builder: (ctx, data, ch) => data.taskInCompleted.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: data.taskInCompleted.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                //     _delete(context, data.task[i]);
                                providerData.deletTask(data.taskInCompleted[i]);
                              },
                            ),
                            trailing: Checkbox(
                              activeColor: Colors.blue,
                              value: checkValue(
                                data.taskInCompleted[i].checkValue,
                              ),
                              onChanged: (bool value) {
                                updateData = data.taskInCompleted[i];

                                int checkvalueonChage = value == true ? 1 : 0;

                                updateData.checkValue = checkvalueonChage;
                                setState(() {
                                  //      update(updateData);
                                  providerData.updateTask(updateData);
                                });
                              },
                            ),
                            title: Text(data.taskInCompleted[i].title),
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
