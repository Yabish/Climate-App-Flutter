import 'package:clima/services/location_service.dart';
import 'package:clima/services/network_service.dart';
import 'package:flutter/material.dart';

const apiKey = 'ce9fb687add6d80a823548eefceb4f09';

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

    bool isEnable = await location.isLocationEnabled();

    print('isEnable:::::::::: $isEnable');

    NetworkHelper networkHelper = NetworkHelper(
      'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=$apiKey',
    );

    var weatherData = await networkHelper.getData();
    // print(weatherData);
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
          ElevatedButton(
            onPressed: () {},
            child: const Text('Get'),
          ),
        ],
      ),
    );
  }
}
