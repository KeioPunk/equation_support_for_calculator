
import '../models/calculation.dart';

class CalculatorController {
  double parseNumber(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      throw const FormatException('Empty input');
    }
    // Use double.parse to support real numbers, exponent notation, etc.
    final value = double.tryParse(trimmed);
    if (value == null || value.isNaN) {
      throw FormatException('Invalid number: "$input"');
    }
    return value;
  }

  /// Basic calculation for two real numbers. Throws ArgumentError on invalid op
  /// or if dividing by zero.
  Calculation calculate(double a, double b, String op) {
    double result;
    switch (op) {
      case '+':
        result = a + b;
        break;
      case '-':
        result = a - b;
        break;
      case '*':
        result = a * b;
        break;
      case '/':
        if (b == 0.0) {
          // define behavior: throw to signal error to the UI/controller caller
          throw ArgumentError('Division by zero');
        }
        result = a / b;
        break;
      default:
        throw ArgumentError('Unsupported operator: $op');
    }

    // Normalize small negative zeros
    if (result == 0) result = 0.0;

    return Calculation(a: a, b: b, op: op, result: result);
  }

  /// Convenience method: parse inputs (strings), validate operator, compute.
  /// Throws FormatException or ArgumentError.
  Calculation calculateFromStrings(String aStr, String bStr, String op) {
    final a = parseNumber(aStr);
    final b = parseNumber(bStr);
    final validOps = ['+', '-', '*', '/'];
    if (!validOps.contains(op)) {
      throw ArgumentError('Operator must be one of: \${validOps.join(' ')}');
    }
    return calculate(a, b, op);
  }
}
