import 'package:flutter/material.dart';
import 'package:flutter_book_app/states/current_user.dart';
import 'package:provider/provider.dart';
import '../services/database.dart' as services;

import '../widgets/container.dart';
import 'add_book.dart';
import 'root.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void _goToAddBook({
    required BuildContext context,
    required String groupName,
  }) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AddBook(),
      ),
      (route) => false,
    );
  }

  final TextEditingController _groupNameTextEditingController =
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
                    controller: _groupNameTextEditingController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: 'Group Name',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () => _goToAddBook(
                      context: context,
                      groupName: _groupNameTextEditingController.text,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        'Create',
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
