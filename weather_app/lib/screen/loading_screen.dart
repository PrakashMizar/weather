import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longtitude);
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?id=2172797&appid=acd7db633f44cc69cf09cf5825ea8a61'),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      var weatherDesc = jsonDecode(data)['coord'][0]['description'];

      print(longitude);
      print(weatherDesc);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather APP API'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.cloud),
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/cloudy.png'),
              colorBlendMode: BlendMode.colorDodge,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'WEATHER: Get Location',
              style: TextStyle(
                fontFamily: 'Dancing',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
              onPressed: () => getLocation(),
              child: Text(
                'Get LatLon',
                style: TextStyle(
                  fontFamily: 'Dancing',
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
