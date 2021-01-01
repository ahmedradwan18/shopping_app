import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/product.dart';
import '../constants.dart';

class Store {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice
    });
  }

  Future<List<Product>> loudProducts() async {
    var snapshot = await _firestore.collection(kProductsCollection).get();
    List<Product> products = [];
    for (var doc in snapshot.docs) {
      var data = doc.data;
      // products.add(Product());
    }
    return products;
  }
}
