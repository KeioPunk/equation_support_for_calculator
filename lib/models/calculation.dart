// lib/models/calculation.dart


class Calculation {
final double a;
final double b;
final String op; // "+", "-", "*", "/"
final double result;


Calculation({required this.a, required this.b, required this.op, required this.result});


@override
String toString() => '$a $op $b = $result';
}