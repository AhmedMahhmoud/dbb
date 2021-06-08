import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = "cache.db";
  static Database _database;
  DatabaseHelper() {
    database;
  }
  initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myOwnDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute('''
           CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT ,name TEXT NOT NULL,email TEXT NOT NULL ,password TEXT NOT NULL) 
          
        ''');
  }

  Future<void> insertIntotable(User user) async {
    try {
      await _database
          .insert("Users", user.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .then((value) {
        print("Sucess");
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
      return _database;
    }
    return _database;
  }

  Future<List<User>> getUsers() async {
    try {
      final List<Map<String, dynamic>> users =
          await _database.query("Users").catchError((e) {
        print(e);
      });
      return List.generate(users.length, (index) {
        return User(
            email: users[index]["email"],
            name: users[index]["name"],
            password: users[index]["password"]
            // rePassword: users[index]["rePassword"],
            //    expiryDate: users[index]["expiryDate"];
            );
      });
    } catch (e) {
      print(e);
    }
  }
}

class User {
  String name, password, email;
  User({this.email, this.name, this.password});

  Map<String, dynamic> toMap() {
    return {
      "name": this.name, "password": this.password, "email": this.email
      // "rePassword": this.rePassword
      //   "expiryDate": this.expiryDate
    };
  }
}
