import 'package:flutter/material.dart';
import 'package:quicktask/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          elevation: 0,
          centerTitle: true,
        ),  
      )
    );
  }
}