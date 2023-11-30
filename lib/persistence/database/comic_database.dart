import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ComicHubDatabaseContext {
  final int version = 1;
  final String databaseName = 'comic.db';
  final String tableName = 'favorite_comics';
  late Database _database;

  Future<Database> openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (database, version) {
        String initialQuery = 'create table $tableName ('
            'id integer primary key,'
            'name varchar(255),'
            'gender varchar(255),'
            'intelligence varchar(255),'
            'imageUrl varchar(255)'
            ')';
        database.execute(initialQuery);
      },
    );
    return _database;
  }
}