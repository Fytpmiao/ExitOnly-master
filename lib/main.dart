import 'package:eoapp/core/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/wrapper.dart';
import 'package:get/get.dart';
import "package:firebase_core/firebase_core.dart";

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create:(_) => AuthService(),)
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      );
  }
}
