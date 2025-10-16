import 'dart:math';

Map<String, dynamic> calcular(String operacion, double num1, double num2) {
  double? resultado;
  int? cociente;
  int? residuo;
  String mensaje = '';

  switch (operacion) {
    case 'suma':
      resultado = num1 + num2;
      break;
    case 'resta':
      resultado = num1 - num2;
      break;
    case 'multiplicación':
      resultado = num1 * num2;
      break;
    case 'división':
      if (num2 == 0) {
        mensaje = 'Error: División por cero';
      } else {
        resultado = num1 / num2;
        cociente = num1 ~/ num2;
        residuo = num1 % num2 as int;
      }
      break;
    case 'potencia':
      resultado = pow(num1, num2).toDouble();
      break;
    case 'raíz':
      if (num2 == 0) {
        mensaje = 'El índice de la raíz no puede ser 0';
      } else if (num1 < 0 && num2 % 2 == 0) {
        mensaje = 'No se puede calcular raíz par de número negativo';
      } else {
        resultado = pow(num1, 1 / num2).toDouble();
      }
      break;
    case 'logaritmo':
      if (num1 <= 0) {
        mensaje = 'El argumento debe ser > 0';
      } else if (num2 <= 0 || num2 == 1) {
        mensaje = 'La base debe ser > 0 y distinta de 1';
      } else {
        resultado = log(num1) / log(num2);
      }
      break;
    default:
      mensaje = 'Operación no válida';
  }

  return {
    'resultado': resultado,
    'cociente': cociente,
    'residuo': residuo,
    'mensaje': mensaje,
  };
}
