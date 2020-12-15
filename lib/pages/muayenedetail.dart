import 'package:flutter/material.dart';
class MuayeneDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Muayene Detayalar"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Geri Dön!'),
        ),
      ),
    );
  }
}