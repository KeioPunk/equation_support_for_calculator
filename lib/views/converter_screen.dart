import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/converter_controller.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KM to Miles Converter'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Enter distance in kilometers:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Kilometers',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                // Saadame andmed kontrollerisse
                context.read<ConverterController>().convert(value);
              },
            ),
            const SizedBox(height: 30),
            // See osa kuulab kontrollerit ja uueneb ise!
            Consumer<ConverterController>(
              builder: (context, controller, child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Result: ${controller.miles.toStringAsFixed(2)} Miles',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('BACK TO CALCULATOR'),
            ),
          ],
        ),
      ),
    );
  }
}