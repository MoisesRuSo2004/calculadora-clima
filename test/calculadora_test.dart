import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_clima/utils/calculadora_logic.dart';

void main() {
  group('Pruebas básicas de calculadora', () {
    test('Suma de 2 + 3 debe ser 5', () {
      final r = calcular('suma', 2, 4);
      expect(r['resultado'], equals(5));
      expect(r['mensaje'], isEmpty);
    });

    test('División por cero debe dar mensaje de error', () {
      final r = calcular('división', 10, 0);
      expect(r['resultado'], isNull);
      expect(r['mensaje'], contains('División por cero'));
    });

    test('Operación inválida debe dar mensaje de error', () {
      final r = calcular('modulo', 4, 2);
      expect(r['resultado'], isNull);
      expect(r['mensaje'], contains('Operación no válida'));
    });
  });
}
