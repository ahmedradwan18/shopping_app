import 'package:flutter/material.dart';
import 'package:shopping_app/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id:(context)=>LoginScreen()
      },
    );
  }
}
