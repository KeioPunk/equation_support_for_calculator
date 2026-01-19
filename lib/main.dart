import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/converter_controller.dart';
import 'package:calculatorrr/views/calculator_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // See rida ühendab ConverterControlleri kogu äpiga
        ChangeNotifierProvider(create: (_) => ConverterController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculatorrr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorView(),
    );
  }
}