import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/services/store.dart';
import 'package:shopping_app/widgets/custom_text_field.dart';


class AddProduct extends StatelessWidget {
  static String id = 'AddProductScreen';
  final _store = Store();
   String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: missing_required_param
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: missing_required_param
            CustomTextField(
              hint: 'Product Price',
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: missing_required_param
            CustomTextField(
              hint: 'Product Description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: missing_required_param
            CustomTextField(
              hint: 'Product Category',
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: missing_required_param
            CustomTextField(
              hint: 'Product Location',
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey != null) {

                }
                if (_globalKey.currentState.validate()) {
                _globalKey.currentState.save();
                _store.addProduct(Product(
                pName: _name,
                pPrice: _price,
                pDescription: _description,
                pLocation: _imageLocation,
                pCategory: _category ));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
