import 'package:brew_crew/Models/brew_models.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'brew_list.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.brown[50],
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
              child: SettingsForm(),
            );
          },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Brew Crew"),
          //centerTitle: true,
          backgroundColor: Colors.brown[400],
          actions: [
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.logout),
                label: Text("Logout"),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()
        ),
        backgroundColor: Colors.brown[50],
      ),
    );
  }
}
