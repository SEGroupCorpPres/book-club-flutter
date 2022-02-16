import 'package:flutter/material.dart';
import 'package:flutter_book_app/states/current_user.dart';
import 'package:provider/provider.dart';
import '../../../widgets/container.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _fullNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailNameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordNameTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordNameTextEditingController =
      TextEditingController();
  void _signUp({
    required String email,
    required String password,
    required String fullName,
    required BuildContext context,
  }) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnMessage = await _currentUser.signUpWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      if (_returnMessage == 'success') {
        Navigator.pop(context);
      } else {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnMessage),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Containerr(
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _fullNameTextEditingController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'Full Name',
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _emailNameTextEditingController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordNameTextEditingController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _confirmPasswordNameTextEditingController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Confirm Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              if (_passwordNameTextEditingController.text ==
                  _confirmPasswordNameTextEditingController.text) {
                _signUp(
                  email: _emailNameTextEditingController.text,
                  password: _passwordNameTextEditingController.text,
                  fullName: _fullNameTextEditingController.text,
                  context: context,
                );
              } else {
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password do\'t match'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
