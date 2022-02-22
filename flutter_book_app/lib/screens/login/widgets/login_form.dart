import 'package:flutter/material.dart';
import 'package:flutter_book_app/screens/home.dart';
import 'package:flutter_book_app/screens/root.dart';
import 'package:flutter_book_app/widgets/container.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import '../../../states/current_user.dart';
import '../../signup/signup.dart';

enum LoginType {
  email,
  google,
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  void _login({
    required LoginType type,
    String? email,
    String? password,
    required BuildContext context,
  }) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String? _returnMessage;
      switch (type) {
        case LoginType.email:
          _returnMessage = await _currentUser.loginWithEmailAndPassword(
            email: email!,
            password: password!,
          );
          break;
        case LoginType.google:
          _returnMessage = await _currentUser.signInWithGoogle();
          break;
        default:
      }

      if (_returnMessage == 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Root(),
          ),
          (route) => false,
        );
      } else {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnMessage!),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Widget _googleButton() {
    // ignore: deprecated_member_use
    return OutlineButton(
      onPressed: () {
        _login(type: LoginType.google, context: context);
      },
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      highlightElevation: 0,
      borderSide: const BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(AntDesign.google),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign In With Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController _emailNameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordNameTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Containerr(
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              'Login',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
            controller: _emailNameTextEditingController,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
            controller: _passwordNameTextEditingController,
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              _login(
                type: LoginType.email,
                email: _emailNameTextEditingController.text,
                password: _passwordNameTextEditingController.text,
                context: context,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: const Text('Don\'t have any account? Sign Up here'),
          ),
          _googleButton(),
        ],
      ),
    );
  }
}
