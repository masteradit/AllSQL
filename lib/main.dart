import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(AllSqlApp());
}

class AllSqlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllSQL',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
