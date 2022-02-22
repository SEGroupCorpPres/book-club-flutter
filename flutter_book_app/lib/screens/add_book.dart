import 'package:flutter/material.dart';
import 'package:flutter_book_app/states/current_user.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../services/database.dart' as services;

import '../widgets/container.dart';
import 'root.dart';

class AddBook extends StatefulWidget {
  final bool? onGroupCreation;
  final String? groupName;
  const AddBook({
    Key? key,
    this.onGroupCreation,
    this.groupName,
  }) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  void _createGroup({
    required BuildContext context,
    required String groupName,
    required Book book,
  }) async {
    CurrentUser _currentuser = Provider.of<CurrentUser>(context);
    String _returnMessage = await services.DataBase().createGroup(
      groupName,
      _currentuser.getUser.uid,
      book!,
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

  final TextEditingController _groupNameTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: const <Widget>[
                BackButton(),
              ],
            ),
          ),
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
                    onPressed: () {
                      Book? book;
                      _createGroup(
                        context: context,
                        groupName: _groupNameTextEditingController.text,
                        book: book!,
                      );
                    },
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
