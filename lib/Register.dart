import 'package:db_task/database.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

TextEditingController repassword = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";

  String password = "";

  String name = "";
  TextEditingController textEditingController = TextEditingController();
  String phone = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                registerFormField(
                  label: "Name",
                  obsecure: false,
                ),
                SizedBox(height: 5),
                registerFormField(
                  label: "Email",
                  obsecure: false,
                ),
                SizedBox(
                  height: 5,
                ),
                registerFormField(
                  label: "Password",
                  obsecure: false,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != password) {
                      return "Mismatch password";
                    }
                  },
                  obscureText: true,
                  controller: textEditingController,
                  style: TextStyle(fontSize: 19, height: 1.5),
                  decoration: InputDecoration(
                    labelText: "Repassword",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 160,
                    color: Colors.purple,
                    child: TextButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (!_formKey.currentState.validate()) {
                          return;
                        } else {
                          DatabaseHelper db = DatabaseHelper();

                          await db
                              .insertIntotable(User(
                                  email: email, name: name, password: password))
                              .whenComplete(() => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  )));
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerFormField({
    String label,
    bool obsecure,
  }) {
    return TextFormField(
      validator: (value) {
        if (label == "Name") {
          if (value.isEmpty) {
            return ("Name is required !");
          } else if (value.length < 3) {
            return ("Minimum Name length is 3");
          }
        }

        if (label == "Email") {
          if (value.isEmpty) {
            return ("Email is required !");
          } else if (!value.contains("@") || !value.contains(".com")) {
            return ("Please enter a valid email !");
          }
        }
        if (label == "Password") {
          if (value.isEmpty) {
            return ("Password is required !");
          } else if (value.length < 5) {
            return ("Password is too short minimun is 5");
          }
        }
      },
      obscureText: obsecure,
      onSaved: (newValue) {
        if (label == "Name") {
          print("name");
          name = newValue.trim();
        } else if (label == "Email") {
          email = newValue.trim();
        } else if (label == "Password") {
          password = newValue.trim();
        }
      },
      keyboardType: label == "Phone Number"
          ? TextInputType.phone
          : label == "Email"
              ? TextInputType.emailAddress
              : TextInputType.multiline,
      style: TextStyle(fontSize: 19, height: 1.5),
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
    );
  }
}
