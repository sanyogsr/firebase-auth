import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screens/home_screen.dart';
import 'package:firebase_practice/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      print('fill all details');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => HomeScreen()));
        }
      } on FirebaseException catch (ex) {
        print(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
      // color: Colors.white,
    );
  }

  Widget _page() {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            SizedBox(
              height: 100,
            ),
            _inputfield('Username', emailController),
            SizedBox(
              height: 30,
            ),
            _inputfield('Password', passwordController, isPassword: true),
            SizedBox(
              height: 60,
            ),
            _btn(),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                               SignUpScreen()));
                },
                child: Text('Create New Account'))
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        shape: BoxShape.circle,
      ),
      child:  Icon(
        Icons.person,
        color: Colors.white,
        size: 70,
      ),
    );
  }

  Widget _inputfield(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.white, width: 1));
    return TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: border,
          focusedBorder: border,
        ));
  }

  Widget _btn() {
    return ElevatedButton(
        onPressed: () {
          print('Button Pressed');
          print('Username: ' + emailController.text);
          print('Password: ' + passwordController.text);
          login();
        },
        child: Text('Sign In'));
  }
}
