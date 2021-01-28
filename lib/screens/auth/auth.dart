import 'package:brew_crew/screens/auth/register.dart';
import 'package:brew_crew/screens/auth/sign_in.dart';
import "package:flutter/material.dart";

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool showSignIn = true;
  void toggleAuthScreen(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn==true){
      return Container(
        child: SignIn(toggleAuthScreen: toggleAuthScreen),
      );
    }
    else{
      return Container(
        child: Register(toggleAuthScreen: toggleAuthScreen),
      );
    }
  }
}
