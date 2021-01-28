import 'package:brew_crew/Models/user_models.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0","1","2","3","4","5"];

  //states of the form
  String _currentSugars;
  String _currentName;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels>(context);
    return StreamBuilder<UserDataModels>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserDataModels userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update your brew settings",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                //name field
                TextFormField(
                  decoration: textInputDecor,
                  initialValue: userData.name,
                  validator: (val) => val.isEmpty ? "Enter Your Name" : null, //somehow not working
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecor,
                  value: _currentSugars ?? userData.sugars,
                  onChanged: (val){
                    setState(()=>_currentSugars=val);
                  },
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),

                    );
                  }).toList(),

                ),
                SizedBox(height: 20.0),
                //slider
                Slider(
                  value: (_currentStrength??userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val){
                    setState(()=>_currentStrength = val.round());
                  },
                ),
                SizedBox(height: 20.0),
                //Update button
                RaisedButton(
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.brown[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                )

              ],
            ),
          );
        }
        else{
          return Loading();
        }
      }
    );
  }
}
