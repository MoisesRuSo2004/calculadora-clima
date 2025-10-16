import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:lottie/lottie.dart';
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
    if (desc.contains('tormenta') || desc.contains('storm')) {
      return WeatherIcons.thunderstorm;
    } else if (desc.contains('lluvia') ||
        desc.contains('rain') ||
        desc.contains('chubasco') ||
        desc.contains('llovizna')) {
      return WeatherIcons.rain;
    } else if (desc.contains('nube') || desc.contains('cloud')) {
      return WeatherIcons.cloudy;
    } else if (desc.contains('despejado') || desc.contains('clear')) {
      return WeatherIcons.day_sunny;
    } else if (desc.contains('nieve') || desc.contains('snow')) {
      return WeatherIcons.snow;
    } else {
      return WeatherIcons.day_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FutureBuilder<WeatherModel>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Error al cargar el clima'));
          }

          final weather = snapshot.data!;
          final weatherIcon = getWeatherIcon(weather.description);

          return SizedBox.expand(
            child: Stack(
              children: [
                WeatherBackground(
                  description: weather.description,
                  isNight: false,
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Clima en Cartagena de Indias 🇨🇴',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
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
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildDataCard(
                              '🌡️ Temperatura',
                              '${weather.temp.toStringAsFixed(1)}°C',
                            ),
                            _buildDataCard(
                              '💧 Humedad',
                              '${weather.humidity}%',
                            ),
                            _buildDataCard(
                              '🌬️ Viento',
                              '${weather.windSpeed} m/s',
                            ),
                            _buildDataCard(
                              '☁️ Nubes',
                              '${weather.cloudiness}%',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherBackground extends StatelessWidget {
  final String description;
  final bool isNight;

  const WeatherBackground({
    super.key,
    required this.description,
    required this.isNight,
  });

  @override
  Widget build(BuildContext context) {
    final desc = description.toLowerCase();
    String animationPath = 'assets/animations/Weather_sunny.json';

    if (desc.contains('tormenta') || desc.contains('storm')) {
      animationPath = 'assets/animations/Weather_storm.json';
    } else if (desc.contains('lluvia') ||
        desc.contains('chubasco') ||
        desc.contains('llovizna') ||
        desc.contains('rain')) {
      animationPath = 'assets/animations/Rainyicon.json';
    } else if (desc.contains('nube') || desc.contains('cloud')) {
      animationPath = 'assets/animations/Weather_windy.json';
    } else if (desc.contains('despejado') || desc.contains('clear')) {
      animationPath = isNight
          ? 'assets/animations/Weather_night.json'
          : 'assets/animations/Weather_sunny.json';
    } else if (isNight) {
      animationPath = 'assets/animations/Weather_night.json';
    }

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isNight
                      ? [Colors.indigo.shade900, Colors.black]
                      : [Colors.lightBlue.shade200, Colors.blue.shade400],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Lottie.asset(
              animationPath,
              fit: BoxFit.cover,
              repeat: true,
              errorBuilder: (context, error, stackTrace) {
                print(
                  '❌ Error al cargar animación: $animationPath\nError: $error',
                );
                return const Center(
                  child: Text(
                    '🌤️ Fondo no disponible',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
