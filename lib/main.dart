import 'package:HATEM_CIRO/pages/welcome.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HATEM CIRO GIDISAT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff004667),
        accentColor: Color(0xffd10f41),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
