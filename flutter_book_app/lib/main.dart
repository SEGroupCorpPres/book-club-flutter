import 'package:flutter/material.dart';
import 'package:flutter_book_app/states/current_user.dart';
import 'package:flutter_book_app/utils/theme.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'screens/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Themes().buildTheme(),
        home: const LoginScreen(),
      ),
    );
  }
}
