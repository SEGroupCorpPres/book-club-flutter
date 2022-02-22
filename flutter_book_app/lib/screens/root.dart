import 'package:flutter/material.dart';
import 'package:flutter_book_app/screens/login/login.dart';
import 'package:flutter_book_app/screens/no_group.dart';
import 'package:provider/provider.dart';

import '../states/current_group.dart';
import '../states/current_user.dart';
import 'home.dart';
import 'splash.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  late AuthStatus _authStatus = AuthStatus.unknown;
  @override
  void didChangeDependencies() async {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnMessage = await _currentUser.onStartUp();
    if (_returnMessage == 'success') {
      if (_currentUser.getUser.groupId != null) {
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
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
      case AuthStatus.inGroup:
        retVal = ChangeNotifierProvider(
          create: (BuildContext context) => CurrentGroup(),
          child: const HomeScreen(),
        );
        // ignore: todo
        // TODO: Handle this case.
        break;
      case AuthStatus.unknown:
        retVal = const SplashScreen();
        // ignore: todo
        // TODO: Handle this case.
        break;
      case AuthStatus.notInGroup:
        retVal = const NoGroup();
        // ignore: todo
        // TODO: Handle this case.
        break;
    }
    return retVal;
  }
}
