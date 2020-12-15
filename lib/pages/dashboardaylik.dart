import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:HATEM_CIRO/api/User.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AylikCiro extends StatefulWidget {
  @override
  _AylikCiroState createState() => _AylikCiroState();
}

class _AylikCiroState extends State<AylikCiro> {
  Future<List<User>> _getUusers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=prefs.getString('token');
    int month=now.month;
    int year=now.year;
    String startDate="01."+month.toString()+"."+now.year.toString();
    String startDateForParse=now.year.toString()+month.toString()+"01";
    DateTime dtFirstDayOfMonth=DateTime.parse(startDateForParse);
    DateTime dtOneMoreMonth=new DateTime(dtFirstDayOfMonth.year,dtFirstDayOfMonth.month+1,dtFirstDayOfMonth.day);
    DateTime dtLastDayOfMonth=new DateTime(dtOneMoreMonth.year,dtOneMoreMonth.month,dtOneMoreMonth.day-1);
    final String endDate = DateFormat('dd.MM.yyyy').format(dtLastDayOfMonth);
    
    var data = await http.get(
        "https://businessapi.hatemhastanesi.com.tr/api/report/get/$startDate/$endDate", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });


    var jsonData = json.decode(data.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(
        u["toplamCiro"],
        u["sigortaCiro"],
        u["ossCiro"],
        u["ozelCiro"],
        u["ameliyatSayisi"],
        u["acilHaricMuayeneSayisi"],
        u["pesinCikis"],
        u["pesinGiris"],
        u["pesinBakiye"],
        u["krediKartiCikis"],
        u["krediKartiGiris"],
        u["krediKartiBakiye"],
        u["acilCiro"],
        u["ayaktanToplam"],
        u["muayeneCiro"],
        u["ayaktanLabCiro"],
        u["ayaktanRadCiro"],
        u["ayaktanRadCiro2"],
        u["ayaktanDigerCiro"],
        u["ameliyatCiro"],
        u["ameliyatCiroFark"],
        u["servisCiro"],
        u["eybCiro"],
        u["ydybCiro"],
      );
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getUusers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: SpinKitCircle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          child: Text(
                            "Hatem Hastanesi Ciro | Aylık",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 25,
                                fontFamily: "Bebas",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          height: 50,
                          color: Colors.grey[300],
                        ),
                        Container(
                          height: 150,
                          child: PageView(
                            controller: PageController(viewportFraction: 0.9),
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true,
                            children: <Widget>[
                              //Toplam Ciro
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Toplam Ciro',
                                            style: TextStyle(
                                              fontFamily: "Bebas",
                                              fontSize: 45,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: oCcy.format((snapshot
                                                      .data[0].toplamCiro)),
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' TL',
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 25,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              //ozelCiro
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Özel Ciro',
                                            style: TextStyle(
                                              fontFamily: "Bebas",
                                              fontSize: 45,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: oCcy.format((snapshot.data[0].ozelCiro)),
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' TL',
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 25,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //sigortaCiro
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Sigorta Ciro',
                                            style: TextStyle(
                                              fontFamily: "Bebas",
                                              fontSize: 45,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: oCcy.format((snapshot
                                                      .data[0].sigortaCiro)),
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' TL',
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 25,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //ossCiro
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'OSS Ciro',
                                            style: TextStyle(
                                              fontFamily: "Bebas",
                                              fontSize: 45,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: oCcy.format((snapshot
                                                      .data[0].ossCiro)),
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 30,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' TL',
                                                  style: TextStyle(
                                                    fontFamily: "Bebas",
                                                    fontSize: 25,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 50,
                          color: Colors.grey[300],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'NAKİT AKIŞ'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'KREDİ AKIŞ'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    oCcy.format((snapshot.data[0].pesinBakiye))+" TL".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    oCcy.format((snapshot.data[0].krediKartiBakiye))+" TL".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                              ),
                              Divider(
                                height: 50,
                                color: Colors.grey[300],
                              ),
                              Text(
                                'KING\'S HAND'.toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontFamily: 'Bebas',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\t Tarihine ait veriler",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 50,
                          color: Colors.grey[300],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: ListView(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.money_off),
                                title: Text('Muayene Sayısı(Acil Hariç)'),
                                subtitle: Text(snapshot.data[0].acilHaricMuayeneSayisi.toString()),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  AlertDialog alert = AlertDialog(
                                    title: Text(
                                        "Bugün Hastanemizde "+ snapshot.data[0].acilHaricMuayeneSayisi.toString() + " muayene yapılmıştır"),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.money_off),
                                title: Text('Ameliyat Sayısı'),
                                subtitle: Text(snapshot.data[0].ameliyatSayisi.toString()),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Bugün hastanemizde "+
                                        snapshot.data[0].ameliyatSayisi.toString()+ " Ameliyat Yapılmıştır"),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.money_off),
                                title: Text('Ameliyat'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  AlertDialog alert = AlertDialog(
                                    title: Text(
                                        "buradan ne gelir artık allah bilir"),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.money_off),
                                title: Text('Çağrı Sayısı'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  AlertDialog alert = AlertDialog(
                                    title: Text(
                                        "buradan ne gelir artık allah bilir"),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.money_off),
                                title: Text('Randevu Sayısı'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  AlertDialog alert = AlertDialog(
                                    title: Text(
                                        "buradan ne gelir artık allah bilir"),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey[300],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'DETAYLAR',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 24,
                                fontFamily: 'Bebas',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/img/down_orange.png',
                                  width: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                ),
                                Text(
                                  'Üç',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

final oCcy = new NumberFormat("#,##0.00", "en_US");

//final formatter = new DateFormat('dd.MM.yyyy');
//final DateTime Today = DateTime.now();
//final String formatted = formatter.format(Today);
final DateTime now = DateTime.now();
final String formattedDate = DateFormat('dd.MM.yyyy').format(now);




