import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/controllers/login_controller.dart';
import 'package:todomobx/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<LoginController>(
      create: (_) => LoginController(),
      child: MaterialApp(
        title: 'MobX Tutorial',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          cursorColor: Colors.deepPurpleAccent,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
