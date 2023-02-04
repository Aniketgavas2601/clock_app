import 'package:clock_app/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database? _database;

  static AlarmHelper? _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper(){
    if(_alarmHelper == null){
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper!;
  }

  Future<Database?> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db,version){
        db.execute('''
         create table $tableAlarm (
         $columnId integer primary key autoIncrement,
         $columnTitle text not null,
         $columnDateTime text not null,
         $columnPending integer,
         $columnColorIndex integer)
        ''');
      }
    );
    return database;
  }
}