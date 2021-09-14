import 'package:flutter/material.dart';

import 'global.dart';
import 'pages/home_page.dart';

void main() {
  runApp(AllSqlApp());
}

class AllSqlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllSQL',
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      themeMode: themeVariable,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
