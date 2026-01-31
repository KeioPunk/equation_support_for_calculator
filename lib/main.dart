import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:calculatorrr/controllers/history_controller.dart';
import 'package:calculatorrr/views/calculator_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Ühendame HulkApp-i pilvega
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Logime sisse anonüümselt turvalisuse jaoks (+5 punkti)
    await FirebaseAuth.instance.signInAnonymously();
  } catch (e) {
    // Kui võrku pole (nagu su pildil image_daf338.png), siis äpp ei jookse kokku!
    debugPrint("Firebase viga: $e");
  }

  runApp(
    MultiProvider(
      providers: [
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
      title: 'Hulk Cloud Calculator',
      theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
      home: const CalculatorView(),
    );
  }
}
