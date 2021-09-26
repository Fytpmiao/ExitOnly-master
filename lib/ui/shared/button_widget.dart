import 'package:flutter/material.dart';
import 'package:eoapp/ui/shared/globals.dart';

class  ButtonWidget extends StatelessWidget {

  final String buttonText;
  final bool border;
  final Color buttonColor;

  ButtonWidget({
    required this.buttonText,
    required this.border,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child:Ink(
        decoration: BoxDecoration(
          color:border?buttonColor:Global.white,
          borderRadius:   BorderRadius.circular(10),
          border: border?Border.all(
              color: buttonColor,
          width:1.0,
          )
              :Border.fromBorderSide(BorderSide.none),
        ),
          child:InkWell(borderRadius: BorderRadius.circular(10),
              child:Container(
                  height: 50,
              child:Center(
              child: Text(
                buttonText,
                style: TextStyle(color:border?Global.white:Global.mediumBlue,
                  fontWeight: FontWeight.w600,
                  fontSize:16.0,
                ),
              )
          )
          )
          ),
      )
    );
  }
}
