import 'package:flutter/material.dart';
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
    _weatherFuture = WeatherService().fetchWeatherByCity(
      'Cartagena',
    ); // Puedes cambiar la ciudad
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<WeatherModel>(
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
          return Center(child: Text('No hay datos disponibles'));
        }

        final weather = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Clima en Cartagena de Indias 🇨🇴',
                    style: theme.textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 16),
                  Icon(Icons.cloud, size: 48, color: theme.primaryColor),
                  const SizedBox(height: 16),
                  Text('🌡️ Temp: ${weather.temp.toStringAsFixed(1)}°C'),
                  Text('💧 Humedad: ${weather.humidity}%'),
                  Text('🌬️ Viento: ${weather.windSpeed} m/s'),
                  Text('☁️ Nubes: ${weather.cloudiness}%'),
                  Text('📝 Estado: ${weather.description}'),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
