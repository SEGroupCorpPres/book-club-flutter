import 'package:flutter/material.dart';

import 'create_group.dart';
import 'join_group.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToJoin({required BuildContext context}) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JoinGroup(),
          ),
        );
    void _goToCreata({required BuildContext context}) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateGroup(),
          ),
        );
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Image.asset('assets/images/logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Welcome to Book Club',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.grey[6000],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Sience you are not in a book club, you can select either to join a club or create a club',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => _goToCreata(context: context),
                  child: const Text('Create'),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => _goToJoin(context: context),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
