import 'package:db_task/LoginScreen.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class HomePage extends StatelessWidget {
  User user;
  List<User> users;
  HomePage(this.user, this.users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome"),
            Text(
              user.name,
              style: TextStyle(fontSize: 40),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Text(users[index].name);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
