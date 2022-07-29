import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timer/main.dart';

void main() {
  testWidgets('Main widget smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify empty list is shown and add new timer button
    expect(find.widgetWithText(AppBar, 'Tiny Timer'), findsOneWidget);
    expect(find.text('No timers found. Add one to get started.'), findsOneWidget);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);

    // Tap the add timer
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pump();

    // Verify that timer has been added.
    expect(find.text('00:00:00'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pump();

    // Verify a second timer has been added.
    expect(find.text('00:00:00'), findsNWidgets(2));
  });
}
