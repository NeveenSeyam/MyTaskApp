import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Data.dart';
import '../provider/task_provider.dart';

class CompletedList extends StatefulWidget {
  @override
  _CompletedListState createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  Data updateData;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<TaskProvider>(context, listen: false);

    return FutureBuilder(
      future: Provider.of<TaskProvider>(context, listen: false)
          .fetchAndSetCompletedTasks(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<TaskProvider>(
                  child: Center(
                    child: const Text('Got no Task yet, start adding some!'),
                  ),
                  builder: (ctx, data, ch) => data.taskCompleted.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: data.taskCompleted.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                //     _delete(context, data.taskCompleted[i]);
                                providerData.deletTask(data.taskCompleted[i]);
                              },
                            ),
                            trailing: Checkbox(
                              activeColor: Colors.blue,
                              value: checkValue(
                                data.taskCompleted[i].checkValue,
                              ),
                              onChanged: (bool value) {
                                updateData = data.taskCompleted[i];

                                int checkvalueonChage = value == true ? 1 : 0;

                                updateData.checkValue = checkvalueonChage;
                                setState(() {
                                  //      update(updateData);
                                  providerData.updateTask(updateData);
                                });
                              },
                            ),
                            title: Text(data.taskCompleted[i].title),
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
