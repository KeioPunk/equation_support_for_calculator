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
  // Meil on nüüd ainult ÜKS kontroller tekstikasti jaoks
  final _equationController = TextEditingController();
  String? _resultText;
  final _controller = CalculatorController();

  void _onCalculate() {
    if (_equationController.text.isEmpty) return;

    try {
      // 1. Arvutame uue kontrolleri abil
      final result = _controller.solveEquation(_equationController.text);
      
      // 2. Teeme vastuse ilusaks (et 8.0 asemel oleks 8)
      String formattedResult = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
      
      // 3. Paneme kokku ajaloo rea (nt "5+6/2 = 8")
      final fullHistoryLine = '${_equationController.text} = $formattedResult';
      
      setState(() {
        _resultText = formattedResult;
      });

      // 4. SALVESTAME AJALUKKU (SQLite töötab taustal edasi!)
      context.read<HistoryController>().addEntry(fullHistoryLine);

    } catch (e) {
      setState(() => _resultText = 'Error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Matemaatika viga, brother!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equation Boss'),
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
          children: [
            TextField(
              controller: _equationController,
              decoration: const InputDecoration(
                labelText: 'Sisesta tehe (nt 5+6/2)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onCalculate,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('CALCULATE'),
            ),
            const SizedBox(height: 40),
            Text(
              _resultText ?? '0',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConverterScreen()),
              ),
              child: const Text('GO TO CONVERTER', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}