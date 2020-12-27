import 'package:flutter/material.dart';
class LogoWidgt extends StatelessWidget {
  const LogoWidgt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage('images/icons/logo.png'),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Shop Now',
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
