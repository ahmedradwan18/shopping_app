import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/productInfo_screen.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/services/store.dart';
import 'package:shopping_app/widgets/productView.dart';

import '../functions.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabBarIndex = 0;
  int bottomBarIndex = 0;
  final _auth = Auth();
  User loggedUser;
  final store = Store();
  List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: bottomBarIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  bottomBarIndex = value;
                });
              },
              fixedColor: kMainColor,
              items: [
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Jackets',
                    style: TextStyle(
                        color: tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 0 ? 16 : null),
                  ),
                  Text(
                    'Trouser',
                    style: TextStyle(
                        color: tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 1 ? 16 : null),
                  ),
                  Text(
                    'T-Shirts',
                    style: TextStyle(
                        color: tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 2 ? 16 : null),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                        color: tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 3 ? 16 : null),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketView(),
                productView(kTrousers, _products),
                productView(kTshirts, _products),
                productView(kShoes, _products),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Material(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Icon(Icons.shopping_cart),
                    onTap: (){
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    loggedUser = await _auth.getUser();
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pId: doc.id,
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
            _products = [
              ...products
            ]; // spread operator y3ny bna5od el values bs w mlhom4 3laka bb3d
            products.clear();
            products = getProductsByCategory(kJackets, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
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
        });
  }
}
