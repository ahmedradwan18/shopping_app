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

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(documentId){
    _firestore.collection(kProductsCollection).doc(documentId).delete();
  }
  editProduct(data,documentId){
    _firestore.collection(kProductsCollection).doc(documentId).update(data);
  }



}
