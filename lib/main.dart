import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const AllSqlApp());
}

class AllSqlApp extends StatelessWidget {
  const AllSqlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllSQL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
