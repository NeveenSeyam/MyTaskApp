import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/tabs_screan.dart';
import './provider/task_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: TaskProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TabsScreen(),
        ));
  }
}
