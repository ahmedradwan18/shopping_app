import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/services/store.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProductScreen';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                products.add(Product(
                    pPrice: data[kProductPrice],
                    pName: data[kProductName],
                    pDescription: data[kProductDescription],
                    pLocation: data[kProductLocation],
                    pCategory: data[kProductCategory]));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .8),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTapUp: (details){
                      double dx=details.globalPosition.dx;
                      double dy=details.globalPosition.dy;
                      double dx2=MediaQuery.of(context).size.width-dx;
                      double dy2=MediaQuery.of(context).size.width-dy;
                      showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, dx2, dy2 ), items: [
                        PopupMenuItem(child: Text('Edit'),),
                        PopupMenuItem(child: Text('Delete'),),
                      ]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Image(
                          image: AssetImage(products[index].pLocation),
                          fit: BoxFit.fill,
                        )),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: .6,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].pName,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('\$ ${products[index].pPrice}')
                                  ],
                                ),
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            } else {
              return Center(child: Text("loading...."));
            }
          }),
    );
  }
}
