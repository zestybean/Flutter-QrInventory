import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_inventory/services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({
    //Constructor
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Textfield controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //*TEXTFIELDS
                  TextFormField(
                    key: const ValueKey("username"),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "Username"),
                  ),
                  TextFormField(
                    key: const ValueKey("password"),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(height: 20),
                  //*BUTTONS
                  ElevatedButton(
                    key: const ValueKey("signIn"),
                    onPressed: () async {
                      final String returnValue =
                          await Auth(auth: widget.auth).signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      if (returnValue == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(returnValue),
                          ),
                        );
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                  ElevatedButton(
                    key: const ValueKey("createAccount"),
                    onPressed: () async {
                      final String returnValue =
                          await Auth(auth: widget.auth).createAccount(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      if (returnValue == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(returnValue),
                          ),
                        );
                      }
                    },
                    child: const Text("Create Account"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
