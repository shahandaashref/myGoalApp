import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goal_app/Feature/Auth/Ui/user_data_provider.dart';
import 'package:goal_app/firebase_options.dart';
import 'package:goal_app/my_app.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
//await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);


  runApp(
    MultiProvider( providers: [ ChangeNotifierProvider(create: (_) => UserDataProvider()), ], child: MyApp(), ),
    );
}



