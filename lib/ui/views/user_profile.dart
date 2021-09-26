import 'package:eoapp/core/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/button_widget.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () async {
              await authService.signOut();
            },
            child: ButtonWidget(
              buttonColor: Colors.red,
              buttonText: 'Log out',
              border: true,
            ),
          ),
        ]
        )
        );
  }
}
