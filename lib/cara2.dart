import 'package:flutter/material.dart';
import 'Alquran.dart';

void main() {
  runApp(MaterialApp(
    title: 'Alqur\'an xii rpl',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alquran xii laravel',
      home: Alquran(),
    );
  }
}
