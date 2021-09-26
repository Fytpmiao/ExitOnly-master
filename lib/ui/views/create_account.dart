import 'package:eoapp/core/auth_service.dart';
import 'package:eoapp/core/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eoapp/ui/shared/globals.dart';
import 'package:provider/provider.dart';
import '../shared/button_widget.dart';

class CreateAccount extends StatelessWidget{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Global.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[Container(
                    alignment:Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(0, 80, 0, 10),
                        child:InkWell(
                          onTap: (){Get.back();},
                          child: Icon(Icons.arrow_back_ios,size:20,color: Global.black,
                          ),
                        )
              ), Text('Create Account',
                      style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
                    SizedBox(height: 20,),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      fillColor: Global.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Global.mediumBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    controller: _nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name cannot be empty';
                      } else
                        return null;
                    },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Global.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Global.mediumBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Email',
                      fillColor: Global.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Global.mediumBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Global.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Global.mediumBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      fillColor: Global.white,
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Global.mediumBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    fillColor: Global.white,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Global.mediumBlue, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                InkWell(onTap: () async {
                  await authService.createUserWithEmailAndPassword (
                      _emailController.text,
                      _pwdController.text);
                      Get.to(() => Wrapper());
                },
                  child: ButtonWidget(
                    buttonColor: Global.mediumBlue,
                    buttonText:'Create Account',
                    border:true,
                  ),
                ),
                ]
            ),
          ),
      )
    );
  }
}
