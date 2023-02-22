import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/auth_controller.dart';
import 'package:todo_app/controller/todo_cotroller.dart';
import 'package:todo_app/view/pages/home/home_page.dart';

void main(List<String> args) {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => TodoController()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
