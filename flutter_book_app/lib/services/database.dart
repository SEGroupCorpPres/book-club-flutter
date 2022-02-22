import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';
import '../models/group.dart';
import '../models/user.dart' as model;

class DataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(model.User user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'timestampUser': Timestamp.now(),
      });
      retVal = 'success';
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<model.User> getUser(String uid) async {
    model.User retVal = model.User();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection('users').doc(uid).get();
      final userdata = _documentSnapshot.data()! as dynamic;
      retVal.uid = uid;
      retVal.fullName = userdata['fullName'];
      retVal.email = userdata['email'];
      retVal.timestampUser = userdata['timestampUser'];
      retVal.groupId = userdata['groupId'];
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<String> createGroup(String groupName, String? userUid, Book? initialBook) async {
    String retVal = 'error';
    List<String> members = [];
    try {
      members.add(userUid!);
      DocumentReference _documentReference =
          await _firestore.collection('groups').add({
        'name': groupName,
        'leader': userUid,
        'members': members,
        'timestamp': Timestamp.now(),
      });
      await _firestore
          .collection('users')
          .doc(userUid)
          .update({'groupId': _documentReference.id});
      retVal = 'success';
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<String> joinGroup(String groupId, String? userUid) async {
    String retVal = 'error';
    List<String> members = [];
    try {
      members.add(userUid!);
      await _firestore
          .collection('groups')
          .doc(groupId)
          .update({'members': FieldValue.arrayUnion(members)});
      await _firestore
          .collection('users')
          .doc(userUid)
          .update({'groupId': groupId});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<Group> getGroup(String groupId) async {
    Group retVal = Group();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection('group').doc(groupId).get();
      final groupdata = _documentSnapshot.data()! as dynamic;
      retVal.id = groupId;
      retVal.name = groupdata['name'];
      retVal.leader = groupdata['leader'];
      retVal.members = List<String>.from(groupdata['members']);
      retVal.timestamp = groupdata['timestamp'];
      retVal.currentBookId = groupdata['currentBookId'];
      retVal.currentBookDue = groupdata['currentBookDue'];
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<Book> getCurrentBook(String groupId, String bookId) async {
    Book retVal = Book();
    try {
      DocumentSnapshot _documentSnapshot = await _firestore
          .collection('group')
          .doc(groupId)
          .collection('books')
          .doc(bookId)
          .get();
      final bookdata = _documentSnapshot.data()! as dynamic;
      retVal.id = bookId;
      retVal.name = bookdata['name'];
      retVal.author = bookdata['author'];
      retVal.length = bookdata['length'];
      retVal.dateCompleted = bookdata['dateCompleted'];
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }
}
