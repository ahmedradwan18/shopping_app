import 'package:flutter/material.dart';
class ModalHud extends ChangeNotifier{
  bool isLoading=false;

  ChangeIsLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
}