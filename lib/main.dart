import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/screens/home_screen.dart';
import 'package:firebase_practice/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}):super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _getInitialScreen()
    );
  }

  Widget _getInitialScreen(){
    if(FirebaseAuth.instance.currentUser != null){
         return HomeScreen();
    }
    else{
return LoginScreen();
    }
  }
}