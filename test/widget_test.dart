import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/main.dart'; // Ensure this matches your package name

void main() {
  testWidgets('Calculator app loads successfully', (WidgetTester tester) async {
    // 1. Load the app
    await tester.pumpWidget(const CalculatorApp());

    // 2. Wait for animations to settle
    await tester.pumpAndSettle();

    // 3. The "Safety" Check:
    // We know a calculator usually displays "0" when it starts.
    // We use 'findsAtLeastNWidgets(1)' so it passes whether you have one "0" or ten "0"s.
    expect(find.text('0'), findsAtLeastNWidgets(1));
  });
}