import 'package:clima/services/location_service.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat = 0;
  double lng = 0;

  Location location = Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    await location.getCurrentLocation();
    setState(() {
      lat = location.latitude;
      lng = location.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Latitude: $lat'),
          ),
          Center(
            child: Text('Longitude: $lng'),
          ),
        ],
      ),
    );
  }
}
