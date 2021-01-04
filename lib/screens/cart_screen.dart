import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/provider/cartItem.dart';
import 'package:shopping_app/screens/productInfo_screen.dart';
import 'package:shopping_app/widgets/custom_menu.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
final double appBarHeight=AppBar().preferredSize.height;
final double statusBarHeight=MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constraint) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight-statusBarHeight-appBarHeight-(screenHeight*0.08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp:(details)=> showCustomMenu(details,context,products[index]),
                        child: Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: screenHeight * 0.15 / 2,
                                backgroundImage:
                                    AssetImage(products[index].pLocation),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '\$ ${products[index].pPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          height: screenHeight * 0.15,
                          color: kSecondaryColor,
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            }else{
              return Container
                (
                height: screenHeight-(screenHeight*0.08)-appBarHeight-statusBarHeight,
                child: Center(
                  child: Text('Cart Is Empty..'),
                ),
              );
            }
          }),
          ButtonTheme(
            minWidth: screenWidth,
            height: screenHeight * 0.08,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Text(
                'order'.toUpperCase(),
              ),
              color: kMainColor,
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details,context,product) async{
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
    items: [
    myPopupMenuItem(
    onClick: () {
Navigator.pop(context);
Provider.of<CartItem>(context,listen: false).deleteProduct(product);
Navigator.pushNamed(context, ProductInfo.id,arguments: product);
    },
    child: Text('Edit'),
    ),
    myPopupMenuItem(
    onClick: () {
      Navigator.pop(context);
      Provider.of<CartItem>(context,listen: false).deleteProduct(product);
    },
    child: Text('Delete'),
    ),
    ]);
  }
}
