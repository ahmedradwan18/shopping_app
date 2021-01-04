import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/admin/ViewOrders.dart';
import 'package:shopping_app/admin/editProduct.dart';
import 'package:shopping_app/admin/orderDetails.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/provider/adminMode.dart';
import 'package:shopping_app/provider/cartItem.dart';
import 'package:shopping_app/provider/modalHud.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/productInfo_screen.dart';
import 'package:shopping_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'admin/addProduct.dart';
import 'admin/adminHome_screen.dart';
import 'admin/manageProducts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Loading...'),
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModalHud>(
                  create: (context) => ModalHud(),
                ),
                ChangeNotifierProvider<AdminMode>(
                  create: (context) => AdminMode(),
                ),
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                )
              ],
              child: MaterialApp(
                initialRoute:isUserLoggedIn?HomeScreen.id: LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignupScreen.id: (context) => SignupScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                  AdminHome.id: (context) => AdminHome(),
                  AddProduct.id: (context) => AddProduct(),
                  ManageProducts.id: (context) => ManageProducts(),
                  EditProduct.id: (context) => EditProduct(),
                  ProductInfo.id: (context) => ProductInfo(),
                  CartScreen.id: (context) => CartScreen(),
                  ViewOrdersScreen.id: (context) => ViewOrdersScreen(),
                  OrderDetails.id: (context) => OrderDetails(),
                },
              ),
            );
          }
        },
        future: SharedPreferences.getInstance());
  }
}
