import 'package:flutter/material.dart';

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

  final List<Map<String, dynamic>> testing = [
    {
      'Column1': 'Data',
      'Column2': 'Data2',
    },
    {
      'Column3': 'SomeMore',
    },
  ];

  @override
  void initState() {
    super.initState();
    _commandType = 'Execute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AllSQL'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(50.0),
        children: [
          const TextField(
            minLines: 4,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Enter your SQL command',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
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
                    borderRadius: BorderRadius.circular(15.0),
                  )),
                ),
                onPressed: () {},
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
            child: Text(
              _descriptions[_commandType] ?? 'Error!',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'OUTPUT',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20.0),
          DataTable(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            columns: testing[0]
                .keys
                .map((e) => DataColumn(
                      label: Text(e),
                    ))
                .toList(),
            rows: [
              DataRow(
                cells: testing[0]
                    .keys
                    .map((e) =>
                        DataCell(Text(testing[0][e] as String? ?? 'null')))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final void Function(String? value)? onChanged;

  const RadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        InkWell(
          onTap: () {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          child: Text(value),
        ),
      ],
    );
  }
}
