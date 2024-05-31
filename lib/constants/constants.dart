class Conditions {
  static const String CLOUD = "clouds";
  static const String MIST = "mist";
  static const String SMOKE = "smoke";
  static const String HAZE = "haze";
  static const String DUST = "dust";
  static const String FOG = "fog";

  static const String RAIN = "rain";
  static const String DRIZZLE = "drizzle";
  static const String SHOWER_RAIN = "shower rain";

  static const String THUNDER = "thunder";
  static const String THUNDERSTORM = "thunderstom";

  static const String SUNNY = "sunny";
  static const String CLEAR = "clear";

  static const CLOUD_FILE = "assets/cloud.json";
  static const RAIN_FILE = "assets/rain.json";
  static const THUNDER_FILE = "assets/thunder.json";
  static const SUNNY_FILE = "assets/sunny.json";
}

const BASE_OPENWEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?";
const BASE_OPENWEATHER_FORECAST_URL =
    "https://api.openweathermap.org/data/2.5/forecast?";
const OPENWEATHER_API_KEY = "caa2ef62488f84f87dc69bcc2d72778e";

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
