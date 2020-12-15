import 'package:HATEM_CIRO/pages/dashboardaylik.dart';
import 'package:HATEM_CIRO/pages/dashboardgunluk.dart';
import 'package:flutter/material.dart';

class SlidePage extends StatefulWidget {
  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {

  PageController controller=PageController();
  List<Widget> _list=<Widget>[
    GunlukCiro(),
    AylikCiro(),
  ];
  int _curr=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children:
          _list,
          scrollDirection: Axis.horizontal,
          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (num){
            setState(() {
              _curr=num;
            });
          },
        ),
    );
  }
}

