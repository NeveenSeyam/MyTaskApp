import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home_list.dart';
import './completed_list.dart';
import './incompleted_list.dart';
import '../Models/Data.dart';
import '../helper/db_helper.dart';
import '../provider/task_provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var addTitleContrler = TextEditingController();
  var addNewTaskCheckValue = false;
  int initialIndex = 0;
  SQL_Helper helper = new SQL_Helper();
  void save(String title, int checkVale) async {
    int result;
    result = await helper.insertStudent(Data(title, checkVale));

    if (result == 0) {
      print("Task not saved");
      Navigator.pop(context);
    } else {
      setState(() {
        initialIndex = 2;
      });
      print('Task  saved"');
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<TaskProvider>(context, listen: false);

    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home List"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: "Task List",
              ),
              Tab(
                icon: Icon(Icons.star),
                text: "Completed List   ",
              ),
              Tab(
                icon: Icon(Icons.star),
                text: "InCompleted List   ",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          HomeList(),
          CompletedList(),
          IncompletedList(),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: addTitleContrler,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Title',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("This task is done ?"),
                                  Checkbox(
                                    value: addNewTaskCheckValue,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        addNewTaskCheckValue = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                child: const Text('Add Task'),
                                onPressed: () {
                                  setState(() {
                                    providerData.addTask(addTitleContrler.text,
                                        addNewTaskCheckValue == true ? 1 : 0);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabsScreen()),
                                    );
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            size: 28,
          ),
        ),
      ),
    );
  }
}
