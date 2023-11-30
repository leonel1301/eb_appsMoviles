import 'package:eb_appsmoviles/models/comicsModel.dart';
import 'package:eb_appsmoviles/persistence/database/comic_database.dart';
import 'package:sqflite/sqflite.dart';

class ComicRepository {
  ComicHubDatabaseContext databaseContext = ComicHubDatabaseContext();

  Future insert(SuperHero superHero) async {
    Database db = await databaseContext.openDb();
    db.insert(databaseContext.tableName, superHero.toDatabaseMap());
  }

  Future delete(SuperHero superHero) async {
    Database db = await databaseContext.openDb();
    db.delete(databaseContext.tableName,
        where: "id=?", whereArgs: [superHero.id]);
  }

  Future<bool> existById(int id) async {
    Database db = await databaseContext.openDb();

    final comics = await db
        .query(databaseContext.tableName, where: "id=?", whereArgs: [id]);

    return comics.isNotEmpty;
  }

  Future<List<SuperHero>> getAll() async {
    Database db = await databaseContext.openDb();
    final characters = await db.query(databaseContext.tableName);
    return characters
        .map((comic) => SuperHero.fromDatabaseMap(comic))
        .toList();
  }
}