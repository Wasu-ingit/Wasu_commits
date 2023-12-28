import 'package:flutter/material.dart';
import 'package:sqlflite_crud/theme/theme.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Manager',
       theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    );
  }
}
