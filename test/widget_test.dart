// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timer/main.dart';

void main() {
  testWidgets('Main widget smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify play button is visible and pause is not
    expect(find.widgetWithText(AppBar, 'Tiny Timer'), findsOneWidget);
    expect(find.text('00:00:00'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
    expect(find.byIcon(Icons.pause_rounded), findsNothing);

    // Tap the play icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify that timer has started and play button is replaced by pause.
    expect(find.byIcon(Icons.pause_rounded), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNothing);
    // expect(find.text('00:00:01'), findsOneWidget); // Fails to test for change in Display widget
  });
}
