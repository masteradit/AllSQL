// ignore_for_file: avoid_dynamic_calls, prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// A service class to interact with the database.
///
/// This class is responsible for opening the database, executing SQL commands,
/// and closing the database.
class DatabaseService {
  late final _factory;
  late final _db;

  DatabaseService();

  /// Initializes the database connection.
  ///
  /// This method sets the database factory to `databaseFactoryFfiWeb` and opens the database.
  /// It returns a `Future` that completes when the initialization is done.
  Future<void> init() async {
    if (kIsWeb) {
      _factory = databaseFactoryFfiWeb;
    } else {
      _factory = databaseFactoryFfi;
    }
    await _openDatabase();
  }

  /// Opens the database.
  Future<void> _openDatabase() async {
    _db = await _factory.openDatabase('all_sql.db');
    debugPrint('Database opened: $_db');
    final sqliteVersion =
        ((await _db.rawQuery('SELECT SQLITE_VERSION()')) as List<Map>)
            .first
            .values
            .first;

    debugPrint('SQLite version: $sqliteVersion');
  }

  ///
  /// Executes the given SQL command on the database.
  ///
  /// This method takes a SQL command as input and executes it on the underlying database.
  /// It returns a [Future] that completes when the execution is finished.
  ///
  /// Example usage:
  /// ```dart
  /// DatabaseService databaseService = DatabaseService();
  /// await databaseService.execute('CREATE TABLE users (id INT, name TEXT)');
  /// ```
  Future<void> execute(String command) async {
    await _db.execute(command);
  }

  /// Inserts a new record into the database using the provided SQL command.
  ///
  /// Returns the number of rows affected by the insert operation.
  ///
  /// The [command] parameter is the SQL command to be executed.
  ///
  /// Example usage:
  /// ```dart
  /// DatabaseService databaseService = DatabaseService();
  /// await databaseService.insert('INSERT INTO users (id, name) VALUES (1, "Adit")');
  /// ```
  Future<int> insert(String command) async {
    return await _db.rawInsert(command) as int;
  }

  /// Executes the given SQL command and returns a list of maps representing the result set.
  ///
  /// The [command] parameter is the SQL command to be executed.
  /// Returns a [Future] that completes with a list of maps, where each map represents a row in the result set.
  /// The keys in the map are column names, and the values are the corresponding column values.
  ///
  /// Example usage:
  /// ```dart
  /// DatabaseService databaseService = DatabaseService();
  /// List<Map<String, Object?>> result = await databaseService.query('SELECT * FROM users');
  /// ```
  Future<List<Map<String, Object?>>> query(String command) async {
    return await _db.rawQuery(command) as List<Map<String, Object?>>;
  }

  /// Updates the database with the given [command].
  /// Returns the number of rows affected by the update operation.
  ///
  /// The [command] parameter is the SQL command to be executed.
  ///
  /// Example usage:
  /// ```dart
  /// DatabaseService databaseService = DatabaseService();
  /// await databaseService.update('UPDATE users SET name = "Adit Luhadia" WHERE id = 1');
  /// ```
  Future<int> update(String command) async {
    return await _db.rawUpdate(command) as int;
  }

  /// Deletes data from the database based on the given command.
  ///
  /// Returns the number of rows affected by the delete operation.
  ///
  /// The [command] parameter is the SQL command to be executed.
  ///
  /// Example usage:
  /// ```dart
  /// DatabaseService databaseService = DatabaseService();
  /// await databaseService.delete('DELETE FROM users WHERE id = 1');
  /// ```
  Future<int> delete(String command) async {
    return await _db.rawDelete(command) as int;
  }
}
