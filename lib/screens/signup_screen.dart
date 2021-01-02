import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/modalHud.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/widgets/custom_text_field.dart';
import 'package:shopping_app/widgets/logo.dart';


import '../constants.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignupScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String mail, password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              LogoWidgt(),
              SizedBox(
                height: height * 0.1,
              ),
              CustomTextField(
                hint: 'Enter your name',
                icon: Icons.perm_identity,
                onClick: (value) {
                  //mail=value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                onClick: (value) {
                  mail = value;
                },
                hint: 'Enter Your email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                onClick: (value) {
                  password = value;
                },
                hint: 'Enter Your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () async {
                      final modalHud =
                          Provider.of<ModalHud>(context, listen: false);
                      modalHud.ChangeIsLoading(true);
                      if (globalKey.currentState.validate()) {
                        // do something
                        globalKey.currentState.save();
                        try {
                          final authResult = await auth.SignUp(mail, password);
                          modalHud.ChangeIsLoading(false);
                        } catch (e) {
                          modalHud.ChangeIsLoading(false);

                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message),
                            ),
                          );
                        }
                      }
                      modalHud.ChangeIsLoading(false);
                    },
                    color: Colors.black,
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
