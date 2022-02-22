import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as model;
import 'package:google_sign_in/google_sign_in.dart';
import '../services/database.dart' as services;
// ignore: unused_import
import 'package:twitter_login/entity/auth_result.dart';

class CurrentUser extends ChangeNotifier {
  late model.User? _user;

  model.User get getUser => _user!;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> onStartUp() async {
    String retVal = 'error';
    try {
      User _firebaseUser = _firebaseAuth.currentUser!;
      _user = await services.DataBase().getUser(_firebaseUser.uid);
      if (_user != null) {
        retVal = 'success';
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await _firebaseAuth.signOut();
      _user = model.User();
      retVal = 'success';
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    String retVal = 'error';
    model.User _user = model.User();
    try {
      // ignore: unused_local_variable
      UserCredential _userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user.uid = _userCredential.user!.uid;
      _user.email = _userCredential.user!.email;
      _user.fullName = fullName;
      String _returnMessage = await services.DataBase().createUser(_user);
      if (_returnMessage == 'success') {
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> signInWithGoogle() async {
    String retVal = 'error';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    model.User? _newUser = model.User();
    try {
      GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? _googleSignInAuthentication =
          await _googleSignInAccount!.authentication;
      final AuthCredential _authCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );
      UserCredential _userCredential =
          await _firebaseAuth.signInWithCredential(_authCredential);
      if (_userCredential.additionalUserInfo!.isNewUser) {
        _newUser.uid = _userCredential.user!.uid;
        _newUser.email = _userCredential.user!.email!;
        _newUser.fullName = _userCredential.user!.displayName;
        services.DataBase().createUser(_newUser);
      }
      _user = await services.DataBase().getUser(_userCredential.user!.uid);
      if (_user != null) {
        retVal = 'success';
      }
    } on ProcessException catch (e) {
      retVal = e.toString();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
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
      _user = await services.DataBase().getUser(_userCredential.user!.uid);
      if (_user != null) {
        retVal = 'success';
      }
    } on ProcessException catch (e) {
      retVal = e.toString();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }
}
