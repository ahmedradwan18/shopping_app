import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/productInfo_screen.dart';

import '../functions.dart';


Widget productView(String pCategory,List<Product>allProduct) {
  List<Product>products;
  products=getProductsByCategory(pCategory,allProduct);
  return  GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: .8),
    itemBuilder: (context, index) =>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].pName,
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$ ${products[index].pPrice}')
                          ],
                        ),
                      ),
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
}
