import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? timestampUser;
  String? groupId;
  User({
    this.uid,
    this.email,
    this.fullName,
    this.timestampUser,
    this.groupId,
  });
}
