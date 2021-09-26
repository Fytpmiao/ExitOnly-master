import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberSelector with ChangeNotifier {

  String unit;
  num price;
  num totalPrice = 0;
  int value = 0;

  NumberSelector(this.unit, [this.price = 0]);

  void increment() {
    value = value + 1;
    notifyListeners();
  }

  void decrement() {
    value = value - 1;
    if (value < 0) {
      value = 0;
    }
    notifyListeners();
  }

  void calculateTotalPrice(){
    totalPrice = value * price;
    notifyListeners();
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     children: [
  //       IconButton(
  //           onPressed: () {this.setState(() {
  //             this._decrement();
  //             this._calculateTotalPrice();
  //           });},
  //           icon: const Icon(Icons.remove)),
  //       Text("${this.value}${this.widget.unit}"),
  //       IconButton(
  //           onPressed: () {this.setState(() {
  //             this._increment();
  //             this._calculateTotalPrice();
  //           });},
  //           icon: const Icon(Icons.add)),
  //     ],
  //   );
  // }
