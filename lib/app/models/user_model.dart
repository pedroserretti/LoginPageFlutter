// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String? id;
  final String? name;
  final String? email;


  UserModel({
    this.name,
    this.email,
    this.id  
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      name: snapshot['user'],
      email: snapshot['email'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name" : name,
    "email" : email,  
    "id": id,
  };
}
