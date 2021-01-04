import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/services/store.dart';
import 'package:shopping_app/widgets/custom_text_field.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProductScreen';
  final _store = Store();
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
            Column(
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
                      _store.editProduct(({
                        kProductName:_name,
                        kProductLocation:_imageLocation,
                        kProductCategory:_category,
                        kProductDescription:_description,
                        kProductPrice:_price  ,
                      }), product.pId);
                    }
                  },
                  child: Text('Edit Product'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
