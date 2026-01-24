import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/calculator_controller.dart';
import 'package:calculatorrr/controllers/history_controller.dart';
import 'package:calculatorrr/views/converter_screen.dart';
import 'package:calculatorrr/views/history_screen.dart';

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

  // Meie vana hea kalkulaatori kontroller
  final _controller = CalculatorController();

  void _onCalculate() {
    try {
      // 1. Teeme arvutuse täpselt nii nagu enne
      final result = _controller.calculateFromStrings(
        _aController.text,
        _bController.text,
        _selectedOp,
      );
      
      final calculationText = '${result.a} ${result.op} ${result.b} = ${result.result}';
      
      // 2. Uuendame ekraani, et kasutaja näeks tulemust
      setState(() {
        _resultText = calculationText;
      });

      // 3. UUS: Salvestame selle sama tulemuse SQLite andmebaasi
      context.read<HistoryController>().addEntry(calculationText);

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
        title: const Text('Hulk Calculatorrrr'),
        centerTitle: true,
        // UUS: Lisasime siia ajaloo nupu
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            ),
          ),
        ],
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
                ElevatedButton(onPressed: _onCalculate, child: const Text('CALCULATE')),
              ],
            ),
            const SizedBox(height: 24),
            // See on sinu tulemuse kuvamise kast (jäi samaks, lisasime vaid taustavärvi)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50, 
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(
                _resultText ?? 'Result will appear here',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            // SINU VANA NAVIGATSIOONINUPP (jääb täpselt samaks!)
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