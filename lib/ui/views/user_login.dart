import 'package:eoapp/core/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/textFieldWidget.dart';
import 'package:provider/provider.dart';
import 'create_account.dart';
import '../shared/button_widget.dart';
import 'package:eoapp/ui/shared/globals.dart';


class UserLogin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<UserLogin> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Global.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*0.15),
              Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(10, 30, 30, 30),
                  child: Text('Sign In',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold))),
              Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('Email')),
              TextFieldWidget(
                controller: emailController,
                placeholder: 'you@example.com',
                hideText: false,
                prefixIcon: Icons.mail_outline,
              ),
              SizedBox(height: 10.0,),
              Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('Password')),
              TextFieldWidget(
                controller: pwdController,
                placeholder: 'Enter your password',
                hideText: _isVisible ? false : true,
                prefixIcon: Icons.lock_clock_outlined,
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on isVisible state choose the icon
                    _isVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Update the state i.e. toggle the state of isVisible variable
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 40.0,),
              InkWell(
                onTap: () {
                  authService.signInWithEmailAndPassword(
                      emailController.text, pwdController.text);
                },
                child: ButtonWidget(
                  buttonColor: Global.mediumBlue,
                  buttonText: 'Login',
                  border: true,
                ),
              ),
              Container(alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: InkWell(
                      onTap: () {
                        Get.to(() => CreateAccount());
                      },
                      child: Text('or Sign Up'))),
            ],
          ),
        ),
      ),
    );
  }
}

