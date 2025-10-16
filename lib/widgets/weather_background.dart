import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

    // ✅ Ruta corregida para Flutter Web (build/web/assets/assets/animations/)
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

    print(
      '🌤️ Cargando animación: $animationPath para descripción: "$description" (isNight: $isNight)',
    );

    return SizedBox.expand(
      // ✅ Asegura que el fondo tenga espacio completo
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
          Align(
            alignment: Alignment.topCenter, // ✅ sube la animación
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  0.5, // ✅ reduce altura al 50%
              width: double.infinity,
              child: Lottie.asset(
                animationPath,
                fit: BoxFit.contain, // ✅ evita que se estire
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
          ),
        ],
      ),
    );
  }
}
