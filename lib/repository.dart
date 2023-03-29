import 'package:flutter_ps_sqflit_automichabits_ssk/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  DatabaseConnection? _databaseConnection;
  static Database? _database;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  Future<Database?> get database async{
    if(_database == null){
      _database = await _databaseConnection?.setDatabase();
    }else{
      return _database;
    }
  }
  insertData(table, data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }
  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async{
    var connection = await database;
    return await connection?.query(table, where: "id=?",whereArgs: [itemId]);
  }

  updateData(table, data) async{
    var connection = await database;
    return await connection?.update(table, data, where: "id=?", whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async{
    var connection = await database;
    return await connection?.rawDelete('delete from $table where id = $itemId');
  }
  readDataByColumnName(table, columnName, columnValue) async{
    var connection = await database;
    return await connection?.query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }

}