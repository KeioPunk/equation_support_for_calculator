import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/converter_controller.dart';
import 'package:calculatorrr/controllers/history_controller.dart';
import 'package:calculatorrr/views/calculator_view.dart';

void main() {
  // SEE RIDA ON KRIITILINE: See lubab SQLite-l failisüsteemiga rääkida 
  // enne kui äpp ametlikult startib!
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConverterController()),
        ChangeNotifierProvider(create: (_) => HistoryController()),
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
      title: 'Calculatorrrr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorView(),
    );
  }
}