import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hulk Cloud History'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: context.read<HistoryController>().historyStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Viga pilvest laadimisel!'));
          }
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('Pilv on tühi, brother! Tee mõni arvutus.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: const Icon(Icons.cloud_done, color: Colors.orange),
                title: Text(data['calculation'] ?? ""),
                subtitle: const Text("Salvestatud pilve"),
              );
            },
          );
        },
      ),
    );
  }
}