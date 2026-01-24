import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Laeme andmed andmebaasist sisse niipea kui ekraan avaneb
    context.read<HistoryController>().loadHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => context.read<HistoryController>().clearHistory(),
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: Consumer<HistoryController>(
        builder: (context, controller, child) {
          if (controller.history.isEmpty) {
            return const Center(child: Text('No history yet, brother! Arvuta midagi kõigepealt!'));
          }
          return ListView.builder(
            itemCount: controller.history.length,
            itemBuilder: (context, index) {
              final item = controller.history[index];
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  item['calculation'], 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
                subtitle: Text('Aeg: ${item['timestamp']}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}