import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/database.dart' as services;
import '../states/current_user.dart';
import '../widgets/container.dart';
import 'root.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({Key? key}) : super(key: key);

  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  Book? book;
  void _joinGroup({
    required BuildContext context,
    required String groupId,
    Book? book,
  }) async {
    CurrentUser _currentuser = Provider.of<CurrentUser>(context);
    String _returnMessage = await services.DataBase().createGroup(
      groupId,
      _currentuser.getUser.uid,
      book,
    );
    if (_returnMessage == 'success') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Root(),
        ),
        (route) => false,
      );
    }
  }

  final TextEditingController _groupIdTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: const <Widget>[
                BackButton(),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Containerr(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupIdTextEditingController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: 'Group Id',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () => _joinGroup(
                      context: context,
                      groupId: _groupIdTextEditingController.text,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        'Join',
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
            ),
          ),
        ],
      ),
    );
  }
}
