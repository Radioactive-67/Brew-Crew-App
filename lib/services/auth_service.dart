import 'package:brew_crew/Models/user_models.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create own user model based on the user object i.e. only data we need is kept in the new object
  UserModels _convertToUserModels(User user){
    return user != null ? UserModels(uid:user.uid) : null ;
  }

  //auth change user stream
  Stream<UserModels> get user{
    return _auth.authStateChanges().map(_convertToUserModels);
  }

  //anonymous sign in
  Future signInAnon() async {
    try{

      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _convertToUserModels(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email and password
  Future signInWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _convertToUserModels(user);
    }
    catch(e){
      print("error in signing in with email and password");
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  Future registerWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create a new document for the user with the auto-generated unique uid
      await DatabaseService(uid:user.uid).updateUserData("0", "new user", 100);
      return _convertToUserModels(user);
    }
    catch(e){
      print("error in registering with email and password");
      print(e.toString());
      return null;
    }
  }

  //sing out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print("error occurred while signing out");
      print(e.toString());
      return null;
    }
  }

}