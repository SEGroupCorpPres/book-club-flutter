import 'package:flutter/material.dart';
import '../services/database.dart' as services;
import '../models/group.dart';
import '../models/book.dart';

class CurrentGroup extends ChangeNotifier {
  Group _currentGroup = Group();
  Book _currentBook = Book();

  Group get getCurrentGroup => _currentGroup;
  Book get getCurrentBook => _currentBook;

  void updateStateFromDatabase(String groupId) async {
    try {
      _currentGroup = await services.DataBase().getGroup(groupId);
      _currentBook = await services.DataBase().getCurrentBook(
        groupId,
        _currentGroup.currentBookId!,
      );
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
