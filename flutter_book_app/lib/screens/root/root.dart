import 'package:flutter/material.dart';
import 'package:flutter_book_app/screens/login/login.dart';
import 'package:provider/provider.dart';

import '../../states/current_user.dart';
import '../home.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  late AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  void didChangeDependencies() async {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnMessage = await _currentUser.onStartUp();
    if (_returnMessage == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = const LoginScreen();
        // ignore: todo
        // TODO: Handle this case.
        break;
      case AuthStatus.loggedIn:
        retVal = const HomeScreen();
        // ignore: todo
        // TODO: Handle this case.
        break;
    }
    return retVal;
  }
}
