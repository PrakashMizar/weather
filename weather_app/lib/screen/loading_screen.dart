import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = 'acd7db633f44cc69cf09cf5825ea8a61';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double? latt;
  late double? long;
  late String? wDesc = '';
  // late double? weatherTemp;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latt = location.latitude;
    long = location.longtitude;
    getData();
  }

  void getData() async {
    //'https://api.openweathermap.org/data/2.5/weather?ilat=$latt&lon=$long=2172797&appid=$apiKey'),
    var uri =
        'https://api.openweathermap.org/data/2.5/weather?id=2172797&appid=acd7db633f44cc69cf09cf5825ea8a61';
    http.Response response = await http.get(
      Uri.parse(uri),
    );
    //NetworkHelp nethelper = NetworkHelp(url);
    //var weatherdata =  nethelper.getData()
    if (response.statusCode == 200) {
      String data = response.body;

      var longitude = jsonDecode(data)['coord']['lon'];
      var weatherDesc = jsonDecode(data)['weather'][0]['description'];
      var weatherTemp = jsonDecode(data)['main']['temp'];
      //print in the conosole
      wDesc = weatherDesc;
      print(wDesc);
      print(longitude);
      print(weatherDesc);
      print(weatherTemp);
    } else {
      //check error code for exception handling
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    //move to getlocation())
    //getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather APP API $wDesc '),
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
              'Get weather from API $wDesc',
              style: TextStyle(
                fontFamily: 'Dancing',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              'longitude $long',
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
            Text(
              'Description $wDesc ',
              style: TextStyle(
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
