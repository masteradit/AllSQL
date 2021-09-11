import 'package:allsql/global.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart' as sqflite;
import 'package:sqflite_web/sqflite_web.dart';

import '../widgets/radio_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _commandType;

  final _descriptions = <String, String>{
    'Execute':
        'Execute an SQL query with no return value.\n\nFor example:\nCREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER);',
    'Insert':
        'Execute an SQL INSERT query and show the last inserted row ID\n\nFor example:\nINSERT INTO Test(name, value) VALUES("Adit", 1234);',
    'Query':
        'Execute an SQL SELECT query and show the output.\n\nFor example:\nSELECT * FROM Test;',
    'Update':
        'Execute an SQL UPDATE query and show the number of changes made.\n\nFor example:\nUPDATE Test SET name = "Adit Luhadia", value = 1234 WHERE name = "Adit";',
    'Delete':
        'Execute an SQL DELETE query and show the number of changes made.\n\nFor example:\nDELETE FROM Test WHERE name = "Adit";',
  };

  final _commandController = TextEditingController();

  Widget _output = Container();

  @override
  void initState() {
    super.initState();
    _commandType = 'Execute';
  }

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF463838) : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AllSQL'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 250,
              child: ListTile(
                title: const Text(
                  'Dark Theme',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                leading: Icon(
                  Icons.brightness_6,
                  color: isDark ? Colors.white : Colors.black,
                ),
                trailing: Switch(
                    activeColor: Colors.white,
                    value: isDark,
                    onChanged: (value) {
                      setState(() {
                        isDark = !isDark;
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(50.0),
        children: [
          TextField(
            controller: _commandController,
            minLines: 4,
            maxLines: 10,
            style: TextStyle(
                fontSize: 18.0, color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: 'Enter your SQL command',
              hintStyle: TextStyle(
                  fontSize: 18.0, color: isDark ? Colors.white : Colors.black),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDark ? const Color(0xff0665B1) : Colors.teal,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const SizedBox(width: 20.0),
              RadioButton(
                value: 'Execute',
                groupValue: _commandType,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _commandType = value;
                    }
                  });
                },
              ),
              const SizedBox(width: 20.0),
              RadioButton(
                value: 'Insert',
                groupValue: _commandType,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _commandType = value;
                    }
                  });
                },
              ),
              const SizedBox(width: 20.0),
              RadioButton(
                value: 'Query',
                groupValue: _commandType,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _commandType = value;
                    }
                  });
                },
              ),
              const SizedBox(width: 20.0),
              RadioButton(
                value: 'Update',
                groupValue: _commandType,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _commandType = value;
                    }
                  });
                },
              ),
              const SizedBox(width: 20.0),
              RadioButton(
                value: 'Delete',
                groupValue: _commandType,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _commandType = value;
                    }
                  });
                },
              ),
              const SizedBox(width: 20.0),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 15.0,
                  )),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
                onPressed: () async {
                  final databaseFactory = databaseFactoryWeb;

                  final db = await databaseFactory
                      .openDatabase(sqflite.inMemoryDatabasePath);

                  switch (_commandType) {
                    case 'Execute':
                      await db.execute(_commandController.text);
                      setState(() {
                        _output = Text(
                          'Query Excecuted',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        );
                      });
                      break;

                    case 'Insert':
                      final int lastRow =
                          await db.rawInsert(_commandController.text);
                      setState(() {
                        _output = Text(
                          'ID of last row inserted is $lastRow.',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        );
                      });
                      break;

                    case 'Query':
                      final List<Map<String, Object?>> queryOutput =
                          await db.rawQuery(_commandController.text);

                      if (queryOutput.isEmpty) {
                        _output = Text(
                          'No output!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        );
                      } else {
                        _output = DataTable(
                          columns: queryOutput.first.keys
                              .map((e) => DataColumn(
                                    label: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          rows: queryOutput
                              .map((e) => DataRow(
                                  cells: queryOutput.first.keys
                                      .map((a) => DataCell(Text(
                                            e[a]?.toString() ?? 'null',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )))
                                      .toList()))
                              .toList(),
                        );
                      }

                      setState(() {});

                      break;

                    case 'Update':
                      final int rowsUpdated =
                          await db.rawUpdate(_commandController.text);
                      setState(() {
                        _output = Text(
                          '$rowsUpdated rows updated!',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        );
                      });
                      break;

                    case 'Delete':
                      final int rowsDeleted =
                          await db.rawDelete(_commandController.text);
                      setState(() {
                        _output = Text(
                          '$rowsDeleted rows deleted!',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        );
                      });
                      break;

                    default:
                  }

                  // print(
                  //     'sqlite_master table: ${await db.rawQuery("SELECT * FROM sqlite_master;")}');
                },
                child: Row(
                  children: const [
                    Text(
                      'RUN',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Icon(Icons.play_circle_outline),
                  ],
                ),
              ),
              const SizedBox(width: 20.0),
            ],
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SelectableText(
              _descriptions[_commandType] ?? 'Error!',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'OUTPUT',
            style: TextStyle(
              fontSize: 20.0,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          _output,
        ],
      ),
    );
  }
}
