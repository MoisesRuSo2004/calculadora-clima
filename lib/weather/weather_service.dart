import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String _apiKey = '87953a6f2ff7ea93b31d1ccdfd62e7b7';

  Future<WeatherModel> fetchWeatherByCity(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      print('Error ${response.statusCode}: ${response.body}');
      throw Exception('Error al obtener datos del clima');
    }
  }
}
