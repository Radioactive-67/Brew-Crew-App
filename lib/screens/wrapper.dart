import 'package:brew_crew/Models/user_models.dart';
import 'package:brew_crew/screens/auth/auth.dart';
import 'package:brew_crew/screens/home/home.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModels>(context);
    print(user);

    //chose home or auth widget to load
    if (user==null){
      return Auth();
    }
    else{
      return Home();
    }
  }
}
