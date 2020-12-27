import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
final Function onClick;
  String _errorMessage(String str) {
    switch (str) {
      case 'Enter your name':
        return 'please enter your name!';
      case 'Enter Your email':
        return 'please enter your email!';
      case 'Enter Your password':
        return 'please enter your password!';
    }
  }

  CustomTextField({@required this.hint, @required this.icon, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        obscureText: hint=='Enter Your password' ?true :false,
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
            // ignore: missing_return
          }
        },
        onSaved: onClick,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
