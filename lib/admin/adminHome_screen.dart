import 'package:flutter/material.dart';
import '../constants.dart';
import 'addProduct.dart';
import 'editProduct.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProduct.id);

            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
