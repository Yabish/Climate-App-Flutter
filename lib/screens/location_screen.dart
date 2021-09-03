import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
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
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String message = '';
  String cityName = '';

  @override
  void initState() {
    super.initState();

    _updateUI(widget.locationWeather);
  }

  void _updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather Data';
        cityName = '';
        return;
      }
      dynamic temp = weatherData['main']['temp'];
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      temperature = temp.toInt();
      message = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  void _getCurrentLocationWeather() async {
    dynamic weatherData = await weather.getWeatherData();
    _updateUI(weatherData);
  }

  void _getCityWeatherData(cityName) async {
    dynamic weatherData = await weather.getCityWeather(cityName);
    _updateUI(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _getCurrentLocationWeather();
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      dynamic cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );
                      if (cityName != null || cityName == '') {
                        _getCityWeatherData(cityName);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  '$message in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
