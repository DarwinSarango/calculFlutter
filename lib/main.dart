import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _display = '';
  String _operador = '';
  double? _primerNumero;
  double? _segundoNumero;

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
        _operador = '';
        _primerNumero = null;
        _segundoNumero = null;
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        if (_display.isNotEmpty) {
          _operador = value;
          _primerNumero = double.tryParse(_display);
          _display = '';
        }
      } else if (value == '=') {
        if (_operador.isNotEmpty && _display.isNotEmpty) {
          _segundoNumero = double.tryParse(_display);
          double resultado = 0;
          switch (_operador) {
            case '+':
              resultado = (_primerNumero ?? 0) + (_segundoNumero ?? 0);
              break;
            case '-':
              resultado = (_primerNumero ?? 0) - (_segundoNumero ?? 0);
              break;
            case '×':
              resultado = (_primerNumero ?? 0) * (_segundoNumero ?? 0);
              break;
            case '÷':
              resultado = (_segundoNumero == 0) ? 0 : (_primerNumero ?? 0) / (_segundoNumero ?? 0);
              break;
          }
          _display = resultado.toString();
          _operador = '';
          _primerNumero = null;
          _segundoNumero = null;
        }
      } else {
        _display += value;
      }
    });
  }

  Widget _buildButton(String value, {Color? color, IconData? icon}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 4,
          ),
          onPressed: () => _onPressed(value),
          child: icon != null
              ? Icon(icon, color: Colors.white, size: 28)
              : Text(value, style: const TextStyle(fontSize: 24, color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f2f6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2f3640),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calculate_outlined, color: Colors.white),
            SizedBox(width: 8),
            Text('Calculadora'),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2d3436),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _display = '';
                      _operador = '';
                      _primerNumero = null;
                      _segundoNumero = null;
                    });
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text('Reiniciar', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2f3640),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('÷', color: Colors.orange, icon: Icons.percent),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('×', color: Colors.orange, icon: Icons.close),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-', color: Colors.orange, icon: Icons.remove),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('0'),
                      _buildButton('C', color: Colors.redAccent, icon: Icons.delete_outline),
                      _buildButton('=', color: Colors.green, icon: Icons.check),
                      _buildButton('+', color: Colors.orange, icon: Icons.add),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
