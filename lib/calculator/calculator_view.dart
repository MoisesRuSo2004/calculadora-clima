import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  String _operation = '';
  String _message = '';
  double? _result;
  int? _cociente;
  int? _residuo;

  void _calculate(String operation) {
    final text1 = _num1Controller.text.trim();
    final text2 = _num2Controller.text.trim();

    final num1 = double.tryParse(text1);
    final num2 = double.tryParse(text2);

    setState(() {
      _operation = operation;
      _message = '';
      _result = null;
      _cociente = null;
      _residuo = null;

      if (text1.isEmpty || text2.isEmpty) {
        _message = 'Debes ingresar ambos números';
        return;
      }

      if (num1 == null || num2 == null) {
        _message = 'Entradas inválidas, solo números';
        return;
      }

      switch (operation) {
        case 'suma':
          _result = num1 + num2;
          break;
        case 'resta':
          _result = num1 - num2;
          break;
        case 'multiplicación':
          _result = num1 * num2;
          break;
        case 'división':
          if (num2 == 0) {
            _message = 'Error: División por cero';
          } else {
            _result = num1 / num2;
            _cociente = num1 ~/ num2;
            _residuo = num1 % num2 as int;
          }
          break;
        case 'potencia':
          _result = pow(num1, num2).toDouble();
          break;
        case 'raíz':
          if (num2 == 0) {
            _message = 'El índice de la raíz no puede ser 0';
          } else if (num1 < 0 && num2 % 2 == 0) {
            _message = 'No se puede calcular raíz par de número negativo';
          } else {
            _result = pow(num1, 1 / num2).toDouble();
          }
          break;
        case 'logaritmo':
          if (num1 <= 0) {
            _message = 'El argumento debe ser > 0';
          } else if (num2 <= 0 || num2 == 1) {
            _message = 'La base debe ser > 0 y distinta de 1';
          } else {
            _result = log(num1) / log(num2);
          }
          break;
      }
    });
  }

  void _clear() {
    _num1Controller.clear();
    _num2Controller.clear();
    setState(() {
      _operation = '';
      _message = '';
      _result = null;
      _cociente = null;
      _residuo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: _num1Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Primer número',
              prefixIcon: Icon(Icons.looks_one, color: theme.primaryColor),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _num2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Segundo número',
              prefixIcon: Icon(Icons.looks_two, color: theme.primaryColor),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => _calculate('suma'),
                icon: const Icon(Icons.add),
                label: const Text('Suma'),
              ),
              FilledButton.icon(
                onPressed: () => _calculate('resta'),
                icon: const Icon(Icons.remove),
                label: const Text('Resta'),
              ),
              FilledButton.icon(
                onPressed: () => _calculate('multiplicación'),
                icon: const Icon(Icons.clear),
                label: const Text('Multiplicación'),
              ),
              FilledButton.icon(
                onPressed: () => _calculate('división'),
                icon: const Icon(Icons.horizontal_rule),
                label: const Text('División'),
              ),
              FilledButton.icon(
                onPressed: () => _calculate('potencia'),
                icon: const Icon(Icons.exposure),
                label: const Text('Potencia'),
              ),
              FilledButton.icon(
                onPressed: () => _calculate('raíz'),
                icon: const Icon(Icons.calculate_outlined),
                label: const Text('Raíz'),
              ),
              FilledButton.icon(
                onPressed: () => _calculate('logaritmo'),
                icon: const Icon(Icons.functions),
                label: const Text('Logaritmo'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Card(
              key: ValueKey(_result),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: theme.colorScheme.secondary.withValues(
                alpha: (0.2 * 255).round().toDouble(),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Resultado: $_operation',
                      style: theme.textTheme.titleMedium,
                    ),
                    if (_message.isNotEmpty)
                      Text(_message, style: const TextStyle(color: Colors.red)),
                    if (_result != null)
                      Text(
                        _result! % 1 == 0
                            ? _result!.toInt().toString()
                            : _result!.toStringAsFixed(4),
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_cociente != null && _residuo != null)
                      Text('Cociente: $_cociente | Residuo: $_residuo'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _clear,
            icon: const Icon(Icons.refresh),
            label: const Text('Limpiar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }
}
