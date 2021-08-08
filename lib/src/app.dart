import 'package:flutter/material.dart';
import 'package:recipes_cook/src/screens/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan,
        accentColor: Colors.white,
      ),
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}
