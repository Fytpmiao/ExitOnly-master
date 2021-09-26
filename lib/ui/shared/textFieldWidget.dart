import 'package:flutter/material.dart';
import 'package:eoapp/ui/shared/globals.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {

  final String placeholder;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final bool hideText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  TextFieldWidget({Key? key,
    required this.placeholder,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hideText,
    this.onChanged,
    this.controller,
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged:onChanged,
      obscureText: hideText,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: Icon(
          prefixIcon,
          size:18,
          color:Global.mediumBlue,
        ),
        filled:true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide:   BorderSide(color: Global.mediumBlue),
        ),
          suffixIcon: suffixIcon,
          labelStyle: TextStyle(color: Global.mediumBlue),
        focusColor: Global.mediumBlue,
      ),
    );
  }
}
