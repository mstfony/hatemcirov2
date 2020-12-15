import 'dart:io';
import 'package:HATEM_CIRO/pages/doktorciro.dart';
import 'package:flutter/material.dart';
import 'package:HATEM_CIRO/menu/slidepage.dart';
import 'package:intl/intl.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
  String _userName;
  Nav(this._userName);
}

class _NavState extends State<Nav> {

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    SlidePage(),
    DoktorCiro(),
    Text('HATEM HASTANESİ | Bilgi İşlem Merkezi',
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    ),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'https://i.pravatar.cc/100',
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ("Merhaba "+"${widget._userName}"),
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: 16,
                    fontFamily: "Bebas",
                  ),
                ),
                Text(formattedDate,
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              exit(0);
            },
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: 50,
                  child: Icon(
                    Icons.exit_to_app,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    size: 35,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  width: 20,
                  height: 20,
                  child: Container(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            title: Text(
              'Gösterge Paneli',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics_rounded,
            ),
            title: Text(
              'Doktorlar',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement_rounded,
            ),
            title: Text(
              'Hakkında',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
final DateTime now = DateTime.now();
final String formattedDate = DateFormat('dd.MM.yyyy').format(now);