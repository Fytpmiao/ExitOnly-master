import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeModel extends ChangeNotifier {
  bool _isVisible = false;
  bool _isValid = false;
  get isVisible => _isVisible;

  set isVisible(value){
    _isVisible = value;
    notifyListeners();
  }

  get isValid => _isValid;
  void checkEmail(String input){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input)){
      _isValid = true;
    }
    else{
      _isValid = false;
    }
    notifyListeners();
  }

}
