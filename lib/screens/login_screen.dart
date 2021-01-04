import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/admin/adminHome_screen.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/provider/adminMode.dart';
import 'package:shopping_app/provider/modalHud.dart';
import 'package:shopping_app/screens/signup_screen.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/widgets/custom_text_field.dart';
import 'package:shopping_app/widgets/logo.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
   String mail, password;
  final auth = Auth();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAdmin = false;
  final adminPassword = 'admin1234';

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
                    onPressed: ()  {
                      _validate(context);
                    },
                    color: Colors.black,
                    child: Text(
                      'Login',
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
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .ChangeIsAdmin(true);
                        },
                        child: Text(
                          'i\'m an admin',
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? kMainColor
                                  : Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .ChangeIsAdmin(false);
                        },
                        child: Text('i\'m a user',
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? Colors.white
                                    : kMainColor),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context,listen: false);
    modalHud.ChangeIsLoading(true);

    // check if textFields not empty
    if (globalKey!=null&& globalKey.currentState.validate()) {
      globalKey.currentState.save();

      if (Provider.of<AdminMode>(context,listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await auth.SignIn(mail.trim(), password.trim());
            modalHud.ChangeIsLoading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modalHud.ChangeIsLoading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        } else {
          modalHud.ChangeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong..'),
          ));
        }
      } else {
        try {
          await auth.SignIn(mail, password);
          modalHud.ChangeIsLoading(false);
          Navigator.pushNamed(context, HomeScreen.id);
        } catch (e) {
          modalHud.ChangeIsLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      }
    }
    modalHud.ChangeIsLoading(false);
  }
}
