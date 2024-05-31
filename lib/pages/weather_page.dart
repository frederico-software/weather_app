import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/geolocation_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  final title = "Weather App :: Home";

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Position? pos;
  WeatherModel? weather;
  bool _loading = true;
  String currentTime = "";

  Future<void> _getCurrentLocation() async {
    Position position = await GeoLocationService.determinePosition();
    setState(() {
      pos = position;
    });
  }

  void _getCurrentDateTime() {
    currentTime = DateFormat.jm().format(DateTime.now());
  }

  Future<void> _getWeather() async {
    if (pos == null) {
      return;
    }
    final currentWeather =
        await WeatherService.fetchWeather(pos!.latitude, pos!.longitude);
    setState(() {
      weather = currentWeather;
      _loading = false;
    });
  }

  String _getWeatherAnimation(String? condition) {
    if (condition == null) {
      return Conditions.SUNNY_FILE;
    }

    switch (condition.toLowerCase()) {
      case Conditions.CLOUD:
      case Conditions.MIST:
      case Conditions.SMOKE:
      case Conditions.HAZE:
      case Conditions.DUST:
      case Conditions.FOG:
        return Conditions.CLOUD_FILE;
      case Conditions.RAIN:
      case Conditions.DRIZZLE:
      case Conditions.SHOWER_RAIN:
        return Conditions.RAIN_FILE;
      case Conditions.THUNDER:
      case Conditions.THUNDERSTORM:
        return Conditions.THUNDER_FILE;
      case Conditions.SUNNY:
      case Conditions.CLEAR:
        return Conditions.SUNNY_FILE;
      default:
        return Conditions.SUNNY_FILE;
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentDateTime();
    if (weather == null) {
      _getWeather();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            :
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: const [0.2, 0.5, 0.7, 0.8],
                      colors: [
                        Colors.blue.shade50,
                        Colors.blue.shade100,
                        Colors.blue.shade200,
                        Colors.blue.shade300
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(weather!.city,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        Text(currentTime),
                        Lottie.asset(_getWeatherAnimation(weather!.condition),
                            width: 150, height: 150),
                        Text(weather!.condition, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(weather!.description.toTitleCase()),
                        Text(
                          "${weather!.temperature.round()}ºC",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              _loading = true;
            });
            _getCurrentLocation();
            _getWeather();
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {
                _loading = false;
              });
            });
          },
          icon: const Icon(Icons.refresh),
          label: const Text("Refresh")),
    );
  }
}
