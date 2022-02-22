import 'package:flutter/material.dart';
import 'package:flutter_book_app/screens/no_group.dart';
import 'package:flutter_book_app/screens/root.dart';
import 'package:flutter_book_app/states/current_user.dart';
import 'package:flutter_book_app/widgets/container.dart';
import 'package:provider/provider.dart';

import '../states/current_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentGroup _currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    _currentGroup.updateStateFromDatabase(_currentUser.getUser.groupId!);
  }

  void _goToNoGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NoGroup()),
    );
  }

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnMessage = await _currentUser.signOut();
    if (_returnMessage == 'success') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Root()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Containerr(
              child: Consumer<CurrentGroup>(builder: (
                BuildContext context,
                value,
                Widget? child,
              ) {
                return Column(
                  children: <Widget>[
                    Text(
                      value.getCurrentBook.name ?? 'loading...',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[600],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Due In',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey[600],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (value.getCurrentGroup.currentBookDue != null)
                                  ? value.getCurrentGroup.currentBookDue!
                                      .toDate()
                                      .toString()
                                  : 'loading...',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {},
                      child: const Text(
                        'Finished Book',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Containerr(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Next Book Revealed In',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Text(
                      '22 Hours',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: () => _goToNoGroup(context),
              child: const Text('Book club history'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: () => _signOut(context),
              child: const Text('Sign Out'),
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Theme.of(context).secondaryHeaderColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
