import 'package:flutter_test/flutter_test.dart';
import 'package:calculatorrr/main.dart'; // Nüüd on nimi õige, brother!

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    // Ehitame äpi ja paneme selle käima
    await tester.pumpWidget(const MyApp());

    // Kontrollime, kas pealkiri on olemas
    expect(find.text('Calculatorrr'), findsOneWidget);
  });
}