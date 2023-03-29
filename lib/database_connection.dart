import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'Atomic_Habits');
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
    return database;
  }
  _onCreateDatabase(Database database,int version) async{
    await database.execute('create table habits(id integer primary key autoincrement, habit Text, habitFrequency Text, habitDate Text, isFinished Integer)');
    await database.execute('create table journals(id integer primary key autoincrement, journal Text, journalDate Text)');
  }
  _onUpgradeDatabase(Database database,int oldversion, int newVersion) async{
    await database.execute('drop table habits');
    await database.execute('drop table journals');
    _onCreateDatabase(database, newVersion);
  }
}