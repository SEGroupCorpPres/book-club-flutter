import 'package:cloud_firestore/cloud_firestore.dart';
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
      print(e);
    }
    return retVal;
  }
  Future<model.User> getUser(String uid) async{
    model.User retVal = model.User();
    try{
      DocumentSnapshot _documentSnapshot = await _firestore.collection('users').doc(uid).get();
      final userdata = _documentSnapshot.data()! as dynamic;
      retVal.uid = uid;
      retVal.fullName = userdata['fullName'];
      retVal.email = userdata['email'];
      retVal.timestampUser = userdata['timestampUser'];
    } catch(e){
      print(e);
    }
    return retVal;
  }
}
