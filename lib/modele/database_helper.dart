import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:project_flutter/modele/user.dart';

class DatabaseHelper {
  static final _databaseName = "MyBatabase.bd";
  static final _databaseVersion = 1;

  static final tablePictures = 'image_table';
  static final idPictures = 'id';

  static final path = 'path';
  static final photoname = 'photoname';

  static final tableUser = 'user_table';
  static final idUser = 'id';
  static final passworsUser = 'password';
  static final firstnameUser = 'firstname';
  static final lastnameUser = 'lastname';
  static final birthdateUser = 'birthdate';
  static final phoneUser = 'phone';
  static final emailUser = 'email';

  static final tableReminder = 'reminder_table';
  static final idReminder = 'id';
  static final titleReminder = 'title';
  static final dateTimeReminder = 'date';
  static final commentReminder = 'comment';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tablePictures ( 
        $idPictures TEXT PRIMARY KEY,    
        $path TEXT NOT NULL,
        $photoname TEXT NULL 
      )
    ''');

    await db.execute('''     
      CREATE TABLE $tableUser (
        $idUser TEXT PRIMARY KEY,
        $passworsUser TEXT NOT NULL,
        $firstnameUser TEXT NOT NULL,
        $lastnameUser TEXT NOT NULL,
        $birthdateUser TEXT NOT NULL,
        $phoneUser TEXT NULL,
        $emailUser TEXT NULL UNIQUE
      )
    ''');

    await db.execute('''     
      CREATE TABLE $tableReminder (
        $idReminder TEXT PRIMARY KEY,
        $titleReminder TEXT NOT NULL,
        $commentReminder TEXT NOT NULL,
        $dateTimeReminder TEXT NOT NULL
      )
    ''');

//INSERT INTO $tableUser ($idUser,$passworsUser,$firstnameUser,$lastnameUser,$birthdateUser,$phoneUser,$emailUser) VALUES("Admin_id","admin","firstNameAdmin","lastNameDamin","1999-04-03","00-01-02-03-04","admin@admin.com");
    await db.rawInsert(
        'INSERT INTO $tableUser ($idUser,$passworsUser,$firstnameUser,$lastnameUser,$birthdateUser,$phoneUser,$emailUser) VALUES("Admin_id","admin","firstNameAdmin","lastNameDamin","1999-04-03","00-01-02-03-04","admin@admin.com")');
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, _databaseName);
    debugPrint(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

//--------------------------------------------------------------------------PICTURES-------------------------------------------------------
  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertPicture(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tablePictures, row);
  }

    void deleteAllPicture() async {
    Database? db = await instance.database;
    await db!.delete(tablePictures);
  }
    void deletePicture(String id) async {
    Database? db = await instance.database;
    await db!.delete(tablePictures, where: 'id = ?', whereArgs: [id]);
  }
  Future<int?>? queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tablePictures'));
  }

  Future<List> getAllImage() async {
    Database? db = await instance.database;
    var result =
        await db!.query(tablePictures, columns: [idPictures, path, photoname]);
    return result.toList();
  }

  /*
  Future<int> maxID() async
  {
    Database db = await instance.database;
    int val;
    var res = await db.rawQuery('SELECT $idPictures FROM $tablePictures');
    int max=int.parse(res.first['$idPictures']);
    for(int i=0; i<res.length;i++)
    {
      val= int.parse(res.elementAt(i)['$idPictures']);
      if(max < val )
      {
        max= val;
      }
    }
    return max;
  }
*/

//------------------------------------------------------------------USER--------------------------------------------------------------

  //retourne l'utilisateur en fonction de son email et mdp

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableUser, row);
  }

  Future<User?> getUserConnexion(String email, String pwd) async {
    Database? db = await instance.database;
    List<Map> maps = await db!.query(tableUser,
        columns: [
          idUser,
          passworsUser,
          firstnameUser,
          lastnameUser,
          birthdateUser,
          phoneUser,
          emailUser
        ],
        where: '$passworsUser = ? and  $emailUser = ?',
        whereArgs: [pwd, email]);
    if (maps.length > 0) {
      return User.fromMap(maps.first as Map<String, dynamic>);
    }
    debugPrint("je n'ai rien trouvé");
    return null;
  }

  Future<int?> queryRowCountUser() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tableUser'));
  }

  Future<int?> emailexist(String email) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!
        .rawQuery('SELECT COUNT(*) FROM $tableUser WHERE email = "$email"'));
  }

//------------------------------------------------------------------REMINDER--------------------------------------------------------------

  Future<int> insertReminder(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableReminder, row);
  }

  Future<List> getAllReminder() async {
    Database? db = await instance.database;
    var result =
        await db!.query(tableReminder, columns: [idReminder,titleReminder, dateTimeReminder, commentReminder]);
    return result.toList();
  }

  void deleteReminder(String id) async {
    Database? db = await instance.database;
    await db!.delete(tableReminder, where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> queryRowCountReminder() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tableReminder'));
  }

  Future<int?> titleexist(String title) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) FROM $tableReminder WHERE title = "$title"'));
  }
}
