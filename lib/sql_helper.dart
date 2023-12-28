import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class SQLHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, surname TEXT, job TEXT, phone TEXT, email TEXT, website TEXT, isFavorite INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          return db.execute(
            'ALTER TABLE contacts ADD COLUMN surname TEXT',
          );
        }
        if (oldVersion < 3) {
          return db.execute(
            'ALTER TABLE contacts ADD COLUMN isFavorite INTEGER',
          );
        }
        // Handle other updates in the future
      },
      version: 3, // Increment this number whenever you change the table structure
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await SQLHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SQLHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> searchData(String table, String query) async {
    final db = await SQLHelper.database();
    return db.query(
      table,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }

  static Future<void> update(String table, Map<String, dynamic> data) async {
    final db = await SQLHelper.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  static Future<void> delete(String table, int id) async {
    final db = await SQLHelper.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
