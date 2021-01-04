import 'package:flutter/material.dart';
import 'package:shopping_app/admin/ViewOrders.dart';
import '../constants.dart';
import 'addProduct.dart';
import 'manageProducts.dart';

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
              Navigator.pushNamed(context, ManageProducts.id);

            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ViewOrdersScreen.id);

            },
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
