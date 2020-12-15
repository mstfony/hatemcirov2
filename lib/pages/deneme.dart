import 'dart:convert';
import 'package:http/http.dart' as http;
String _apiUrl = "https://sacekimi.hatemhastanesi.com.tr/api/Auth/login";
Future postContact(email,password) async {
  String apiUrl = '$_apiUrl';
  http.Response response = await http.post(apiUrl,headers: {
    "Accept": "application/json",
    "Accesstoken": "Bearer"
  }, body:  {'email':'$email','password':'$password'});
  print("Result: ${response.body}");
  return json.decode(response.body);
}