import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

bool esNoche(DateTime hora) {
  return hora.hour >= 18 || hora.hour <= 6;
}

IconData obtenerIconoClima(String descripcion, bool isNight) {
  final desc = descripcion.toLowerCase();

  if (desc.contains('rain') || desc.contains('lluvia')) {
    return isNight ? WeatherIcons.night_alt_rain : WeatherIcons.rain;
  }
  if (desc.contains('cloud') || desc.contains('nube')) {
    return isNight ? WeatherIcons.night_alt_cloudy : WeatherIcons.cloudy;
  }
  if (desc.contains('storm') || desc.contains('tormenta')) {
    return isNight
        ? WeatherIcons.night_alt_thunderstorm
        : WeatherIcons.thunderstorm;
  }
  if (desc.contains('snow') || desc.contains('nieve')) {
    return WeatherIcons.snow;
  }
  if (desc.contains('clear') || desc.contains('despejado')) {
    return isNight ? WeatherIcons.night_clear : WeatherIcons.day_sunny;
  }

  return isNight ? WeatherIcons.night_clear : WeatherIcons.day_sunny;
}
