import 'package:flutter_test/flutter_test.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:calculadora_clima/utils/clima_logic.dart';

void main() {
  group('Lógica de clima', () {
    test('Detecta correctamente si es de noche', () {
      expect(esNoche(DateTime(2025, 10, 16, 23)), isTrue); // 11 PM
      expect(esNoche(DateTime(2025, 10, 16, 5)), isTrue); // 5 AM
      expect(esNoche(DateTime(2025, 10, 16, 14)), isFalse); // 2 PM
    });

    test('Devuelve ícono correcto para "lluvia" de noche', () {
      final icono = obtenerIconoClima('lluvia ligera', true);
      expect(icono, equals(WeatherIcons.night_alt_rain));
    });
  });
}
