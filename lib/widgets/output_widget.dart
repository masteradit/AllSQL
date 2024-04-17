import 'package:flutter/material.dart';

import '../models/command_type.dart';

class OutputWidget extends StatelessWidget {
  final int? lastRowId;
  final List<Map<String, dynamic>>? queryResult;
  final int? rowsUpdated;
  final int? rowsDeleted;
  final CommandType commandType;

  const OutputWidget.execute()
      : lastRowId = null,
        queryResult = null,
        rowsUpdated = null,
        rowsDeleted = null,
        commandType = CommandType.execute;

  const OutputWidget.insert({required this.lastRowId})
      : queryResult = null,
        rowsUpdated = null,
        rowsDeleted = null,
        commandType = CommandType.insert;

  const OutputWidget.query({required this.queryResult})
      : lastRowId = null,
        rowsUpdated = null,
        rowsDeleted = null,
        commandType = CommandType.query;

  const OutputWidget.update({required this.rowsUpdated})
      : lastRowId = null,
        queryResult = null,
        rowsDeleted = null,
        commandType = CommandType.update;

  const OutputWidget.delete({required this.rowsDeleted})
      : lastRowId = null,
        queryResult = null,
        rowsUpdated = null,
        commandType = CommandType.delete;

  @override
  Widget build(BuildContext context) {
    switch (commandType) {
      case CommandType.execute:
        return const Text('Executed the command.');
      case CommandType.insert:
        return Text('Last inserted row ID: $lastRowId');
      case CommandType.query:
        if (queryResult!.isEmpty) {
          return const Text('No rows found.');
        }

        return DataTable(
          columns: queryResult!.first.keys
              .map((e) => DataColumn(label: Text(e)))
              .toList(),
          rows: queryResult!.map((e) {
            return DataRow(
              cells: e.values.map((e) => DataCell(Text(e.toString()))).toList(),
            );
          }).toList(),
        );
      case CommandType.update:
        return Text('Number of rows updated: $rowsUpdated');
      case CommandType.delete:
        return Text('Number of rows deleted: $rowsDeleted');
    }
  }
}
