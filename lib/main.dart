import 'package:flutter/material.dart';
import 'package:news_app/pages/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DailyNews",
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}
