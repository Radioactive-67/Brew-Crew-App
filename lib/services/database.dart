import 'package:brew_crew/Models/brew_models.dart';
import 'package:brew_crew/Models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid}); // to associate user with its document/record

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      "sugar" : sugar,
      "name" : name,
      "strength" : strength,
    });
  }

  //brew list from snapshot
  List<Brew> _convertToBrewList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.data()["name"] ?? "new user",
        sugar: doc.data()["sugar"] ?? "0",
        strength: doc.data()["strength"] ?? 100,
      );
    }).toList();
  }

  // get brew stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_convertToBrewList);
  }

  //to convert user data from document snapshot to UserDataModels(self defined model)
  UserDataModels _convertToUserDataModels(DocumentSnapshot snapshot){
    return UserDataModels(
      uid: uid,
      name: snapshot.data()["name"],
      sugars: snapshot.data()["sugar"],
      strength: snapshot.data()["strength"],
    );
  }

  //get user doc stream
  Stream<UserDataModels> get userData {
    return brewCollection.doc(uid).snapshots().map(_convertToUserDataModels);
  }

}