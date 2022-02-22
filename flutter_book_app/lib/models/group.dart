import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String? id;
  String? name;
  String? leader;
  List<String>? members;
  Timestamp? timestamp;
  String? currentBookId;
  Timestamp? currentBookDue;

  Group({
    this.id,
    this.name,
    this.leader,
    this.members,
    this.timestamp,
    this.currentBookId,
    this.currentBookDue,
  });
}