import 'package:allsql/services/database_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DatabaseService Tests', () {
    late DatabaseService databaseService;

    setUp(() async {
      databaseService = DatabaseService();
      await databaseService.init();
      await databaseService.execute('DROP TABLE IF EXISTS users');
      await databaseService.execute('CREATE TABLE users (id INT, name TEXT)');
    });

    test('Execute SQL command', () async {
      final result = await databaseService.query('SELECT * FROM users');
      expect(result, isNotNull);
    });

    test('Insert data', () async {
      await databaseService.insert('INSERT INTO users (id, name) VALUES (1, "John Doe")');
      final result = await databaseService.query('SELECT * FROM users');
      expect(result.length, 1);
      expect(result.first['name'], 'John Doe');
    });

    test('Update data', () async {
      await databaseService.insert('INSERT INTO users (id, name) VALUES (1, "John Doe")');
      await databaseService.update('UPDATE users SET name = "Jane Doe" WHERE id = 1');
      final result = await databaseService.query('SELECT * FROM users');
      expect(result.first['name'], 'Jane Doe');
    });

    test('Delete data', () async {
      await databaseService.insert('INSERT INTO users (id, name) VALUES (1, "John Doe")');
      await databaseService.delete('DELETE FROM users WHERE id = 1');
      final result = await databaseService.query('SELECT * FROM users');
      expect(result.length, 0);
    });
  });
}
