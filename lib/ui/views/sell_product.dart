import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellProduct extends StatelessWidget {
  const SellProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,children:[Center(child:Text("Sell Product"))]);
  }
}
