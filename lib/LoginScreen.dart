import 'package:db_task/Register.dart';
import 'package:db_task/database.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  DatabaseHelper db = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: FutureBuilder(
                future: db.getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Email is required !");
                          } else if (!value.contains("@") ||
                              !value.contains(".com")) {
                            return ("Please enter a valid email !");
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Password is required !");
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                )),
                            child: Container(
                              width: 140,
                              padding: EdgeInsets.all(15),
                              color: Colors.purple,
                              child: Center(
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (!_formKey.currentState.validate()) {
                                DatabaseHelper db = DatabaseHelper();

                                return;
                              } else {
                                print("ss");
                                User x = User();
                                DatabaseHelper db = DatabaseHelper();

                                for (int i = 0; i < snapshot.data.length; i++) {
                                  if (snapshot.data[i].password ==
                                          passController.text &&
                                      snapshot.data[i].email ==
                                          emailController.text) {
                                    x = User(
                                        email: snapshot.data[i].email,
                                        name: snapshot.data[i].name,
                                        password: snapshot.data[i].password);
                                  }
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(x, snapshot.data),
                                    ));
                              }
                            },
                            child: Container(
                              width: 140,
                              padding: EdgeInsets.all(15),
                              color: Colors.purple,
                              child: Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
