class UserModel {
  String uid;
  String email;
  String firstname;
  String age;

  UserModel({this.uid, this.email, this.firstname, this.age});

  //resive data from server
  factory UserModel.fromMap(Map) {
    return UserModel(
      uid: Map['uid'],
      email: Map['email'],
      firstname: Map['firstName'],
      age: Map['age'],
    );
  }

//send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstname,
      'age': age,
    };
  }
}
