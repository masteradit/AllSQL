import 'package:flutter/material.dart';

Widget buildQueryResult(List<List<Map<String, Object?>>> results,
    Color canvasColor, Color indicatorColor) {
  if (results.length < 2) {
    final queryOutput = results.first;
    return DataTable(
      columns: queryOutput.first.keys
          .map((e) => DataColumn(
                label: Text(e),
              ))
          .toList(),
      rows: queryOutput
          .map((e) => DataRow(
              cells: queryOutput.first.keys
                  .map((a) => DataCell(Text(e[a]?.toString() ?? 'null')))
                  .toList()))
          .toList(),
    );
  }
  return Center(
    child: Container(
      height: 300,
      child: DefaultTabController(
        length: results.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(''),
            toolbarHeight: 50,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: canvasColor,
            bottom: TabBar(
                indicatorColor: indicatorColor,
                labelColor: Colors.black,
                tabs: List<Widget>.generate(
                  results.length,
                  (int index) {
                    return Tab(text: 'Query ${index+1}');
                  },
                )),
          ),
          body: TabBarView(
            children: List<Widget>.generate(
              results.length,
              (int index) {
                final queryOutput = results.elementAt(index);
                return DataTable(
                  columns: queryOutput.first.keys
                      .map((e) => DataColumn(
                            label: Text(e),
                          ))
                      .toList(),
                  rows: queryOutput
                      .map((e) => DataRow(
                          cells: queryOutput.first.keys
                              .map((a) => DataCell(Text(e[a]?.toString() ?? 'null')))
                              .toList()))
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
