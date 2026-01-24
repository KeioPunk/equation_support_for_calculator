import 'package:math_expressions/math_expressions.dart';

class CalculatorController {
  // See meetod lahendab võrrandi, kasutades uut GrammarParserit
  double solveEquation(String equation) {
    try {
      // 1. Puhastame teksti (komad punktideks)
      String finalEquation = equation.replaceAll(',', '.');
      
      // 2. Kasutame uut GrammarParserit (vana Parser on pensionil!)
      GrammarParser p = GrammarParser();
      
      // 3. Muudame teksti matemaatiliseks avaldiseks
      Expression exp = p.parse(finalEquation);
      
      // 4. Arvutame vastuse
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      return eval;
    } catch (e) {
      // Kui võrrand on vigane, anname sellest teada
      throw Exception("Vigane võrrand, brother!");
    }
  }
}