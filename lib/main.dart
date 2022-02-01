import 'package:flutter/material.dart';
import 'package:search_user_test/pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Data User',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}
