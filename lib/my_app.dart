import 'package:flutter/material.dart';
import 'package:goal_app/Feature/Pages/Ui/Screens/home_place_holder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: HomePlaceHolder(),
    );
  }
}
