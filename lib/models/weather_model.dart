class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final String description;
  final double feelsLike;
  final double tempMin;
  final double tempMax;

  WeatherModel(
      {required this.city,
      required this.temperature,
      required this.condition,
      required this.description,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json["name"],
      temperature: json["main"]["temp"].toDouble(),
      condition: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      feelsLike: json["main"]["feels_like"].toDouble(),
      tempMin: json["main"]["temp_min"].toDouble(),
      tempMax: json["main"]["temp_max"].toDouble(),
    );
  }
}
