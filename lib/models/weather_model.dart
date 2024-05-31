class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final String description;

  WeatherModel({required this.city, required this.temperature, required this.condition, required this.description});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(city: json["name"], 
    temperature: json["main"]["temp"].toDouble(), 
    condition: json["weather"][0]["main"],
    description: json["weather"][0]["description"]
    );
  }
}