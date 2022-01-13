import 'package:final_todo_app/screens/login.dart';
import 'package:final_todo_app/screens/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/main': (context) => const Main(),
      },
    );
  }
}
