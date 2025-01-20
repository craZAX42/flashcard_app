import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'definitions.dart';
import 'home_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: theme,
        home: HomePage(),
      ),
    );
  }
}
