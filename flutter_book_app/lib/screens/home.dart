import 'package:flutter/material.dart';
import 'package:flutter_book_app/screens/root/root.dart';
import 'package:flutter_book_app/states/current_user.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnMessage = await _currentUser.signOut();
            if (_returnMessage == 'success') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Root()),
                  (route) => false);
            }
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
