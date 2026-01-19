import 'package:flutter/material.dart';
import 'package:calculatorrr/controllers/calculator_controller.dart';
import 'package:calculatorrr/views/converter_screen.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String _selectedOp = '+';
  String? _resultText;

  // Me loome kalkulaatori kontrolleri siin (MVC Controller)
  final _controller = CalculatorController();

  void _onCalculate() {
    try {
      final result = _controller.calculateFromStrings(
        _aController.text,
        _bController.text,
        _selectedOp,
      );
      setState(() {
        _resultText = '${result.a} ${result.op} ${result.b} = ${result.result}';
      });
    } catch (e) {
      setState(() {
        _resultText = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatorrr'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _aController,
              decoration: const InputDecoration(labelText: 'First number (a)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bController,
              decoration: const InputDecoration(labelText: 'Second number (b)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Operator:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedOp,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => _selectedOp = v);
                  },
                  items: const [
                    DropdownMenuItem(value: '+', child: Text('+')),
                    DropdownMenuItem(value: '-', child: Text('-')),
                    DropdownMenuItem(value: '*', child: Text('*')),
                    DropdownMenuItem(value: '/', child: Text('/')),
                  ],
                ),
                const Spacer(),
                ElevatedButton(onPressed: _onCalculate, child: const Text('Calculate')),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _resultText ?? 'Result will appear here',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // NAVIGATSIOONINUPP TEISENDAJA JUURDE
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConverterScreen()),
                );
              },
              child: const Text('GO TO KM/MILES CONVERTER'),
            ),
          ],
        ),
      ),
    );
  }
}