import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ListView(
        children: [
          Padding(
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
          ),
          SizedBox(
            height: height*0.1,
          ),
          CustomTextField(
            hint: 'Enter Your email',
            icon: Icons.email,
          ),
          SizedBox(
            height: height*0.02,
          ),
          CustomTextField(
            hint: 'Enter Your password',
            icon: Icons.lock,
          ),
          SizedBox(
            height: height*0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {},
              color: Colors.black,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: height*0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?',style: TextStyle(
                fontSize: 16,
                color: Colors.white
              ),),
              Text('Login',style: TextStyle(
                  fontSize: 16,
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
