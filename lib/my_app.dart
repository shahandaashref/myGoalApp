import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goal_app/Core/theme.dart';
import 'package:goal_app/Feature/Auth/Ui/login_bage.dart';
import 'package:goal_app/Feature/Pages/Ui/Screens/counter_page.dart';
import 'package:goal_app/Providers/colormode.dart';
import 'package:goal_app/Providers/counter_provder.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: context.read<Colormode>().thememode(),
      home: LoginPage(),
    );
  }
}
