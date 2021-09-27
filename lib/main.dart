import 'package:allsql/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'global.dart';
import 'pages/home_page.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(AllSqlApp());
}

class AllSqlApp extends StatefulWidget {
  @override
  State<AllSqlApp> createState() => _AllSqlAppState();
}

class _AllSqlAppState extends State<AllSqlApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllSQL',
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      themeMode: currentTheme.currentTheme(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
