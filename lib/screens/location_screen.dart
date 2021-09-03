import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    Key? key,
    required this.locationWeather,
  }) : super(key: key);

  final dynamic locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Location'),
      ),
    );
  }
}
