import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import "package:flutter/material.dart";

class Register extends StatefulWidget {

  final Function toggleAuthScreen;
  Register({this.toggleAuthScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //loading state
  bool loading = false;

  //text field states
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign Up to Brew Crew"),
        //centerTitle: true,
        backgroundColor: Colors.brown[400],
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleAuthScreen();
              },
              icon: Icon(Icons.login),
              label: Text("Sign In"),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0 , horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              //email field
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty ? "Enter your email" : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              //password field
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: "password"),
                validator: (val) => val.length < 6 ? "password must be at least 6 characters long" : null,
                onChanged: (val){
                  setState(() => password = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Center(
                child: RaisedButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmail(email, password);
                      if(result == null){
                        setState((){
                          error = "Enter valid email";
                          loading = false;
                        });
                      }
                      //no need of else as the stream listens for auth changes and if result!=null means it will automatically show home screen
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                    ),

                  ),
                  color: Colors.brown[400],
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
