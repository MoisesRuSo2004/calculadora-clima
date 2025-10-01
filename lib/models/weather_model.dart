class WeatherModel {
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double cloudiness;
  final String description;
  final String icon;

  WeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.cloudiness,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp']?.toDouble() ?? 0.0,
      feelsLike: json['main']['feels_like']?.toDouble() ?? 0.0,
      humidity: json['main']['humidity']?.toInt() ?? 0,
      windSpeed: json['wind']['speed']?.toDouble() ?? 0.0,
      cloudiness: json['clouds']['all']?.toDouble() ?? 0.0,
      description: json['weather'][0]['description'] ?? 'Sin descripción',
      icon: json['weather'][0]['icon'] ?? '01d',
    );
  }
}
