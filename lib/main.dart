import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/adminMode.dart';
import 'package:shopping_app/provider/modalHud.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'admin/addProduct.dart';
import 'admin/adminHome_screen.dart';
import 'admin/editProduct.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(
          create: (context) => ModalHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          EditProduct.id: (context) => EditProduct(),
        },
      ),
    );
  }
}