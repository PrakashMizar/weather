import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';

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

  @override
  Widget build(BuildContext context) {
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
