import 'package:flutter/material.dart';
class AmeliyatDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ameliyat Detayalar"),
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