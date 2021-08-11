import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';
import 'package:recipes_cook/src/conecction/server_controller.dart';

class LoginPage extends StatefulWidget {
  ServerController server_controller;
  BuildContext context;

  LoginPage(this.server_controller, this.context, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // VARIABLES
  var username;
  var password;
  var _loading = false;
  String _errorMessage = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyan.shade300,
                    Colors.cyan.shade900,
                  ],
                ),
              ),
              child: Image.asset('assets/image/logo.png'),
              height: 300,
            ),
            Transform.translate(
              offset: Offset(
                0,
                10,
              ),
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Usuario'),
                          onSaved: (value) {
                            username = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Contraseña'),
                            obscureText: true,
                            onSaved: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              ;
                            }),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          onPressed: () => _login(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Iniciar sesion'),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        if (_errorMessage == 'Usuario o contraseña incorrecto') 
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '¿No estas registrado?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/register',
                                );
                              },
                              child: Text('Registrarse'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (!_loading) {
      if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();
        setState(() {
        _loading = true;
        _errorMessage = "";
      });
      User user = await widget.server_controller.login(username, password);
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/home', arguments: user);
      }
      else {
        setState(() {
          _errorMessage = 'Usuario o contraseña incorrecto';
          _loading = false;
        });
      }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    widget.server_controller.init(widget.context);
  }
}
