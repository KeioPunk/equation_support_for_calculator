import 'package:flutter/material.dart';

class ConverterController extends ChangeNotifier {
  double _miles = 0;
  double get miles => _miles;

  void convert(String value) {
    // Teisendame teksti arvuks, kui on vigane tekst, paneme 0
    double kilometers = double.tryParse(value) ?? 0;
    // Valem: Miilid = Kilomeetrid * 0.621371
    _miles = kilometers * 0.621371;
    notifyListeners(); // See uuendab automaatselt ekraani!
  }
}