

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlController with ChangeNotifier{

  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  void update()
  {
    notifyListeners();
  }

  late Database database;
  List localList = [];

  SqlController()
  {
    createLocalStorage(false);
  }
  Future<void> createLocalStorage(bool value)
  async {
    // Fields: Student Name, Date, Present (Yes/No).
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    if(value)
      {
        await deleteDatabase(path);
      }
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, date TEXT ,present INTEGER)');
        });
    readLocalStorage();
  }

  Future<void> insertLocalStorage(
      {required String name,required String date,required int present}) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Test(name, date, present) VALUES(?, ?, ?)',
          [name,date ,present]);
    });
    readLocalStorage();
  }

  Future<void> updateLocalStorage(
      {required String name,required String date,required int present,required int id})
  async {
    await database.rawUpdate(
        'UPDATE Test SET name = ?, date = ?, present = ? WHERE id = ?',
        [name,date,present,id]);
    readLocalStorage();
  }

  Future<void> readLocalStorage()
  async {
    localList = await database.rawQuery('SELECT * FROM Test');
    notifyListeners();
  }

  Future<void> deleteLocalRecord(int id)
  async {
    await database.rawDelete('DELETE FROM Test WHERE id = ?', [id]);
    readLocalStorage();
  }

  Future<void> insertFirebaseToLocal({required String name,required String date,required int present})
  async {
    await createLocalStorage(false);
    localList.clear();
    insertLocalStorage(name: name, date: date, present: present);
  }
  // Future<void> insertLocalStorage(
  //     {required String name,required String date,required int present}) async {
  //   await database.transaction((txn) async {
  //     await txn.rawInsert(
  //         'INSERT INTO Test(name, date, present) VALUES(?, ?, ?)',
  //         [name,date ,present]);
  //   });
  //   readLocalStorage();
  // }
}