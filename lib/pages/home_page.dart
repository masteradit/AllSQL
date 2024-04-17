import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/responsive.dart';
import '../models/command_type.dart';
import '../services/database_service.dart';
import '../widgets/output_widget.dart';
import '../widgets/radio_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _commandController = TextEditingController();
  CommandType? _commandType = CommandType.execute;
  Widget? _output;

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllSQL'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                )
              : const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: _commandController,
              minLines: 4,
              maxLines: 10,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your SQL command';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Enter your SQL command',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioButton<CommandType>(
                      value: CommandType.execute,
                      label: 'Execute',
                      groupValue: _commandType,
                      onChanged: (value) => setState(() {
                        _commandType = value;
                      }),
                    ),
                    RadioButton<CommandType>(
                      value: CommandType.insert,
                      label: 'Insert',
                      groupValue: _commandType,
                      onChanged: (value) => setState(() {
                        _commandType = value;
                      }),
                    ),
                    RadioButton<CommandType>(
                      value: CommandType.query,
                      label: 'Query',
                      groupValue: _commandType,
                      onChanged: (value) => setState(() {
                        _commandType = value;
                      }),
                    ),
                    RadioButton<CommandType>(
                      value: CommandType.update,
                      label: 'Update',
                      groupValue: _commandType,
                      onChanged: (value) => setState(() {
                        _commandType = value;
                      }),
                    ),
                    RadioButton<CommandType>(
                      value: CommandType.delete,
                      label: 'Delete',
                      groupValue: _commandType,
                      onChanged: (value) => setState(() {
                        _commandType = value;
                      }),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SelectableText(
                      Constants.descriptions[_commandType] ?? 'Error!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (!_formKey.currentState!.validate() ||
                      _commandType == null) {
                    return;
                  }

                  try {
                    switch (_commandType!) {
                      case CommandType.execute:
                        await _db.execute(_commandController.text);
                        setState(() {
                          _output = const OutputWidget.execute();
                        });
                      case CommandType.query:
                        final queryResult =
                            await _db.query(_commandController.text);
                        setState(() {
                          _output =
                              OutputWidget.query(queryResult: queryResult);
                        });
                      case CommandType.insert:
                        final lastRowId =
                            await _db.insert(_commandController.text);
                        setState(() {
                          _output = OutputWidget.insert(lastRowId: lastRowId);
                        });
                      case CommandType.update:
                        final rowsUpdated =
                            await _db.update(_commandController.text);
                        setState(() {
                          _output =
                              OutputWidget.update(rowsUpdated: rowsUpdated);
                        });
                      case CommandType.delete:
                        final rowsDeleted =
                            await _db.delete(_commandController.text);
                        setState(() {
                          _output =
                              OutputWidget.delete(rowsDeleted: rowsDeleted);
                        });
                    }
                  } catch (e) {
                    setState(() {
                      _output = Text(e.toString());
                    });
                  }
                },
                icon: const Icon(Icons.play_circle_outline),
                label: const Text('RUN'),
              ),
            ),
            const SizedBox(height: 20.0),
            if (_output != null)
              Text(
                'OUTPUT',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            if (_output != null) const SizedBox(height: 20.0),
            if (_output != null) _output!,
          ],
        ),
      ),
    );
  }
}
