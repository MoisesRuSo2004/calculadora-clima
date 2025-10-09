import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/weather_model.dart';
import 'weather_service.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late Future<WeatherModel> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().fetchWeatherByCity('Cartagena');
  }

  IconData getWeatherIcon(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('rain') || desc.contains('lluvia'))
      return WeatherIcons.rain;
    if (desc.contains('cloud') || desc.contains('nube'))
      return WeatherIcons.cloudy;
    if (desc.contains('clear') || desc.contains('despejado'))
      return WeatherIcons.day_sunny;
    if (desc.contains('storm') || desc.contains('tormenta'))
      return WeatherIcons.thunderstorm;
    if (desc.contains('snow') || desc.contains('nieve'))
      return WeatherIcons.snow;
    return WeatherIcons.day_sunny;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: FutureBuilder<WeatherModel>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar el clima',
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          final weather = snapshot.data!;
          final weatherIcon = getWeatherIcon(weather.description);

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 🌤 Título
                  Text(
                    'Clima en Cartagena de Indias 🇨🇴',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  /// 🌈 Card principal con ícono
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue.shade200,
                            Colors.blue.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          BoxedIcon(
                            weatherIcon,
                            size: 100,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            weather.description.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📦 Cards de datos
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildDataCard(
                        '🌡️ Temperatura',
                        '${weather.temp.toStringAsFixed(1)}°C',
                      ),
                      _buildDataCard('💧 Humedad', '${weather.humidity}%'),
                      _buildDataCard('🌬️ Viento', '${weather.windSpeed} m/s'),
                      _buildDataCard('☁️ Nubes', '${weather.cloudiness}%'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDataCard(String title, String value) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(230),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
