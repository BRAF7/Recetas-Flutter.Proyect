import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';
import 'package:recipes_cook/src/conecction/server_controller.dart';
import 'package:recipes_cook/src/screens/home_page.dart';
import 'package:recipes_cook/src/screens/login_page.dart';
import 'package:recipes_cook/src/screens/register_page.dart';

ServerController _serverController = ServerController();

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
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginPage(_serverController, context);
            case '/home':
              User userLogged = (settings.arguments) as User;
              return HomePage(userLogged);
            default:
              return Container();
          }
        });
      },

    );
  }
}
