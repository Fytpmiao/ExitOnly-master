import 'package:eoapp/core/viewmodels/user_model.dart';
import 'package:eoapp/ui/shared/bottom_navbar.dart';
import 'package:eoapp/ui/views/user_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream:authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? UserLogin() : BottomNavbar();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator(),
          )
          );
        }
      }
    );
  }
}