import '../models/command_type.dart';

class Constants {
  static const Map<CommandType, String> descriptions = {
    CommandType.execute:
        'Execute an SQL query with no return value.\n\nFor example:\nCREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, value INTEGER);',
    CommandType.insert:
        "Execute an SQL INSERT query and show the last inserted row ID\n\nFor example:\nINSERT INTO users(name, value) VALUES('Adit', 1234);",
    CommandType.query:
        'Execute an SQL SELECT query and show the output.\n\nFor example:\nSELECT * FROM users;',
    CommandType.update:
        "Execute an SQL UPDATE query and show the number of changes made.\n\nFor example:\nUPDATE users SET name = 'Adit Luhadia', value = 1234 WHERE name = 'Adit';",
    CommandType.delete:
        "Execute an SQL DELETE query and show the number of changes made.\n\nFor example:\nDELETE FROM users WHERE name = 'Adit';",
  };
}
