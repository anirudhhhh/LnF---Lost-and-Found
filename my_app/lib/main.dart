import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const LostAndFoundApp());
}

class LostAndFoundApp extends StatelessWidget {
  const LostAndFoundApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LnF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LostAndFoundHomePage(),
    );
  }
}
