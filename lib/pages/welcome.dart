import 'dart:convert';
import 'package:HATEM_CIRO/menu/nav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


  bool _isLoading = false;


  login(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    var response = await http.post("https://businessapi.hatemhastanesi.com.tr/api/Auth/login" ,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, String>{'email': email, 'password' : pass}));
    print(response.statusCode);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
       // setState(() {
         // _isLoading = false;
       // });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("userName", email);
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Nav(nameController.text),
          ),
        );
      }
    }
    else {
    // setState(() {
       // _isLoading = false;
    //  });
      print(response.body);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'King\'s Hand'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 48,
                    color: Theme.of(context).accentColor,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/img/illustration.png',
                  width: 300,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  'Bilgi Teknolojileri tarfından geliştirilen bu uygulama; yönetici için anlık veri takip imkanı sağlar.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kulanıcı Adı',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Şifre',
                    ),
                  ),
                ),
                              Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                MaterialButton(
                  onPressed: () {
                    var result=login(nameController.text, passwordController.text);
                    print(nameController.text);
                  },
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    'Giriş Yap'.toUpperCase(),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  height: 50,
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Kayıt Ol'.toUpperCase(),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Şifremi Unuttum'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
