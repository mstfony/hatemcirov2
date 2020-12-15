import 'package:HATEM_CIRO/pages/ameliyatdetail.dart';
import 'package:HATEM_CIRO/pages/muayenedetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:HATEM_CIRO/api/User.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GunlukCiro extends StatefulWidget {
  @override
  _GunlukCiroState createState() => _GunlukCiroState();
}
class _GunlukCiroState extends State<GunlukCiro> {
  Future<List<User>> _getUusers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=prefs.getString('token');
    String userName=prefs.getString('userName');
    print(userName);
    var data = await http.get(
        "https://businessapi.hatemhastanesi.com.tr/api/report/get/$formattedDate/$formattedDate", headers: <String, String>{
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
    /* DateTime suan = DateTime.now();
    DateTime UcAyOncesi = DateTime(suan.year, suan.month - 3);*/
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(new Duration(seconds: 4));
          setState(() {});
        },
        child: Container(
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
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'CİROLAR',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 20,
                                    fontFamily: 'Bebas',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/img/up_red.png',
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15),
                                    ),
                                    Text(
                                      'GÜNLÜK',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          /*  RaisedButton(
                            child: Text("Tarih Seç"),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: suan,
                                      firstDate: UcAyOncesi,
                                      lastDate: suan)
                                  .then((secilentarih) {
                                    String date=formatDate(
                                        secilentarih, [dd, '.', mm, '.', yyyy]).toString();
                                print(date);
                            //    return _getUusers(date, date);
                                    BasTar=date;
                                    BitTar=date;
                                setState(() {_getUusers(BasTar, BitTar);});
                              });
                            },
                          ),*/
                          Divider(
                            height: 25,
                            color: Colors.grey[300],
                          ),
                          Container(
                            height: 210,
                            child: PageView(
                              controller: PageController(viewportFraction: 1.0),
                              scrollDirection: Axis.horizontal,
                              pageSnapping: true,
                              children: <Widget>[
                                //Toplam Ciro
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Toplam Ciro',
                                              style: TextStyle(
                                                fontFamily: "Bebas",
                                                fontSize: 25,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: oCcy.format((snapshot.data[0].toplamCiro)),
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' TL',
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /*CircularPercentIndicator(
                                              radius: 65.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 6.0,
                                              percent:
                                                  snapshot.data[0].toplamCiro /
                                                      1000000,
                                              center: new Text(
                                                "Toplam CIRO",
                                                style: new TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                    fontFamily: "Bebas"),
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              progressColor:
                                                  Theme.of(context).accentColor,
                                            ),*/
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[300],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text('Ayaktan CIRO'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text('Yatan CIRO*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                    color: Colors.grey[300],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'A.H. Sayısı'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Y.H. Sayısı*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
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

                                //Özel Ciro
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Özel Ciro',
                                              style: TextStyle(
                                                fontFamily: "Bebas",
                                                fontSize: 25,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: oCcy.format((snapshot.data[0].ozelCiro)),
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' TL',
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /*CircularPercentIndicator(
                                              radius: 65.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 6.0,
                                              percent:
                                                  snapshot.data[0].toplamCiro /
                                                      1000000,
                                              center: new Text(
                                                "Toplam CIRO",
                                                style: new TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                    fontFamily: "Bebas"),
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              progressColor:
                                                  Theme.of(context).accentColor,
                                            ),*/
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[300],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text('Ayaktan CIRO'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text('Yatan CIRO*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                    color: Colors.grey[300],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'A.H. Sayısı'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Y.H. Sayısı*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
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

                                //SigortaCiro
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Sigorta Ciro',
                                              style: TextStyle(
                                                fontFamily: "Bebas",
                                                fontSize: 25,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: oCcy.format((snapshot.data[0].sigortaCiro)),
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' TL',
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /*CircularPercentIndicator(
                                              radius: 65.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 6.0,
                                              percent:
                                                  snapshot.data[0].toplamCiro /
                                                      1000000,
                                              center: new Text(
                                                "Toplam CIRO",
                                                style: new TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                    fontFamily: "Bebas"),
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              progressColor:
                                                  Theme.of(context).accentColor,
                                            ),*/
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[300],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text('Ayaktan CIRO'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text('Yatan CIRO*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                    color: Colors.grey[300],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'A.H. Sayısı'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Y.H. Sayısı*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
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
                                //öss Ciro
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Öss Ciro',
                                              style: TextStyle(
                                                fontFamily: "Bebas",
                                                fontSize: 25,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: oCcy.format((snapshot.data[0].ossCiro)),
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' TL',
                                                    style: TextStyle(
                                                      fontFamily: "Bebas",
                                                      fontSize: 25,
                                                      color: Theme.of(context).accentColor,
                                                      fontWeight:FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /*CircularPercentIndicator(
                                              radius: 65.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 6.0,
                                              percent:
                                                  snapshot.data[0].toplamCiro /
                                                      1000000,
                                              center: new Text(
                                                "Toplam CIRO",
                                                style: new TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                    fontFamily: "Bebas"),
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              progressColor:
                                                  Theme.of(context).accentColor,
                                            ),*/
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[300],
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text('Ayaktan CIRO'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text('Yatan CIRO*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color:Theme.of(context).primaryColor,
                                                          fontWeight:FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color:Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                    color: Colors.grey[300],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'A.H. Sayısı'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Y.H. Sayısı*'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Theme.of(context).primaryColor,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(oCcy.format((snapshot.data[0].ayaktanToplam)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                      Text(oCcy.format((snapshot.data[0].servisCiro)) +" TL".toUpperCase(),
                                                        style: TextStyle(
                                                          color: Theme.of(context).accentColor,
                                                        ),
                                                      ),
                                                    ],
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
                            height: 25,
                            color: Colors.grey[300],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'AKIŞLAR',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20,
                                  fontFamily: 'Bebas',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/img/up_red.png',
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                  ),
                                  Text(
                                    'Nakit - Kredi',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                                ),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      oCcy.format((snapshot.data[0].pesinBakiye)) +" TL".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      oCcy.format((snapshot.data[0].krediKartiBakiye)) +" TL".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),

                                Divider(
                                  height: 10,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Merhabalar",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Merhabalar",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      oCcy.format((snapshot.data[0].pesinBakiye)) +" TL".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      oCcy.format((snapshot.data[0].krediKartiBakiye)) +" TL".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),

                                Divider(
                                  height: 10,
                                  color: Colors.grey[300],
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
                                'Detaylar',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20,
                                  fontFamily: 'Bebas',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/img/up_red.png',
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                  ),
                                  Text(
                                    'Günlük veriler',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Muayene Verileri (Acil Hariç)',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('Muayene Sayısı: ' + snapshot.data[0].acilHaricMuayeneSayisi.toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                      Text('Muayene Ciro: ' + oCcy.format(snapshot.data[0].muayeneCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MuayeneDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),

                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Acil Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('Acil Hasta Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),//değişecek
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                      Text('Acil Ciro: ' + oCcy.format(snapshot.data[0].acilCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),

                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Ameliyat Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('Ameliyat Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text('Ameliyat Ciro: ' + oCcy.format(snapshot.data[0].ameliyatCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Laboratuvar Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('Lab Tetkik Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),//değişecek
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text('Lab Ciro(ayaktan): ' + oCcy.format(snapshot.data[0].ayaktanLabCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Radyoloji Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('Rad Tetkik Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),//değişecek
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text('Rad Ciro(ayaktan): ' + oCcy.format(snapshot.data[0].ayaktanRadCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Erişkin YB. Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('EYB Hasta Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),//değişecek
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text('EYB Ciro: ' + oCcy.format(snapshot.data[0].eybCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),

                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Yenidoğan YB. Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('YDYB Hasta Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),//değişecek
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text('YDYB Ciro: ' + oCcy.format(snapshot.data[0].ydybCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: Icon(Icons.money_off),
                                  title: Center(
                                    child: Text(
                                      'Servis Verileri',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Text('Servis Yatan Sayısı: ' + snapshot.data[0].ameliyatSayisi.toString(),//değişecek
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      Text('Servis Ciro: ' + oCcy.format(snapshot.data[0].servisCiro),
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor
                                        ),),
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AmeliyatDetail()),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 10,
                                  color: Colors.grey[300],
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
                                'Servis',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20,
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
                                    'Doluluk Oranı',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Container(
                            height: 250,
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: ListView(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                StatCard(
                                  title: 'Doktor1',
                                  title1: 'deneme',
                                  // oCcy.format((snapshot.data[0].toplamCiro)),
                                  achieved: (snapshot.data[0].toplamCiro),
                                  total: 1111350,
                                  color: Colors.green,
                                  image: Image.network(
                                      'https://www.hatemhastanesi.com.tr/images/hekimler/400x600/MTU5MDFmN2E2ODU4MzE.png',
                                      width: 30),
                                ),
                                StatCard(
                                  title: 'Doktor1',
                                  achieved: 350,
                                  total: 300,
                                  color: Theme.of(context).primaryColor,
                                  image: Image.network(
                                      'https://www.hatemhastanesi.com.tr/images/hekimler/400x600/MTU5MDFmN2E2ODU4MzE.png',
                                      width: 30),
                                ),
                                StatCard(
                                  title: 'Doktor1',
                                  achieved: 100,
                                  total: 200,
                                  color: Colors.green,
                                  image: Image.network(
                                      'https://www.hatemhastanesi.com.tr/images/hekimler/400x600/MTU5MDFmN2E2ODU4MzE.png',
                                      width: 30),
                                ),
                                StatCard(
                                  title: 'Doktor1',
                                  title1: 'deneme',
                                  achieved: 350,
                                  total: 300,
                                  color: Theme.of(context).primaryColor,
                                  image: Image.network(
                                      'https://www.hatemhastanesi.com.tr/images/hekimler/400x600/MTU5MDFmN2E2ODU4MzE.png',
                                      width: 30),
                                ),
                                StatCard(
                                  title: 'Doktor1',
                                  achieved: 100,
                                  total: 200,
                                  color: Colors.green,
                                  image: Image.network(
                                      'https://www.hatemhastanesi.com.tr/images/hekimler/400x600/MTU5MDFmN2E2ODU4MzE.png',
                                      width: 30),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String title1;
  final double total;
  final double achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key key,
    @required this.title,
    @required this.title1,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).accentColor.withAlpha(100),
                  fontSize: 14,
                ),
              ),
              achieved < total
                  ? Image.asset(
                      'assets/img/down_orange.png',
                      width: 20,
                    )
                  : Image.asset(
                      'assets/img/up_red.png',
                      width: 20,
                    ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: achieved / (total < achieved ? achieved : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: image,
            progressColor: color,
            backgroundColor: Theme.of(context).accentColor.withAlpha(30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              TextSpan(
                text: ' / $total',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

final oCcy = new NumberFormat("#,##0.00", "en_US");

final DateTime now = DateTime.now();
final String formattedDate = DateFormat('dd.MM.yyyy').format(now);
/*String BasTar = formattedDate;
 String BitTar = formattedDate;*/
