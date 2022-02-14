import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;
  String get getEmail => _email;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    String retVal = 'error';
    try {
      // ignore: unused_local_variable
      UserCredential _userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      retVal = 'success';
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> signInWithGoogle() async {
    return 'error';
  }

  Future<String> signInWithFacebook() async {
    return 'error';
  }

  Future<String> signInWithTwitter() async {
    return 'error';
  }

  Future<String> signInWithYahoo() async {
    return 'error';
  }

  Future<String> signInWithMicrosoft() async {
    return 'error';
  }

  Future<String> signInWithApple() async {
    return 'error';
  }

  Future<String> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    String retVal = 'error';
    try {
      UserCredential _userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _uid = _userCredential.user!.uid;
      _email = _userCredential.user!.email!;
      retVal = 'success';
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }
}
