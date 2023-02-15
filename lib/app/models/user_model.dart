// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String? id;
  final String? name;
  final String? email;
  final String? password;


  UserModel({
    this.name,
    this.email,
    this.id,
    this.password
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      id: snapshot['id'],
      password: snapshot['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name" : name,
    "email" : email,  
    "id": id,
    "password": password
  };
}
