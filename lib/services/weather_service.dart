import 'dart:convert';

import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const API_KEY = OPENWEATHER_API_KEY;

  static const BASE_WEATHER_URL = BASE_OPENWEATHER_URL;
  static const BASE_FORECAST_URL = BASE_OPENWEATHER_FORECAST_URL;

  static String _buildWeatherURL(String lat, String lon) {
    return "${BASE_WEATHER_URL}lat=$lat&lon=$lon&units=metric&appid=$API_KEY";
  }

  static String _buildForecastURL(String lat, String lon) {
    return "${BASE_FORECAST_URL}lat=$lat&lon=$lon&units=metric&appid=$API_KEY";
  }

  static Future<WeatherModel> fetchWeather(double lat, double lon) async {
    String formattedURL = _buildWeatherURL(lat.toString(), lon.toString());

    final response = await http.get(Uri.parse(formattedURL));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error trying to load weather data.");
    }
  }

  static Future<Map> fetchForecast(double lat, double lon) async {
    String formattedURL = _buildForecastURL(lat.toString(), lon.toString());

    final response = await http.get(Uri.parse(formattedURL));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error trying to load weather data.");
    }
  }
}
