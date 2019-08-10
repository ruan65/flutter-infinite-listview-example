import 'package:flutter/material.dart';
import 'package:infinite_listview_example/injection_container.dart';
import 'package:infinite_listview_example/ui/list/list_page.dart';

void main() {
  initKiwi();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}
