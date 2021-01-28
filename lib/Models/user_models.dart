class UserModels{
  final String uid;
  UserModels({this.uid});
}

class UserDataModels{
  final String name;
  final String uid;
  final String sugars;
  final int strength;

  UserDataModels({this.uid, this.sugars, this.strength, this.name});
}