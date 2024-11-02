import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aigo/main.dart'; // Ganti 'your_app_name' dengan nama paket aplikasi Anda

void main() {
  testWidgets('Home Page displays welcome message and button',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MyApp());

    // Verify that the welcome message is displayed
    expect(find.text('Selamat datang di aplikasi kami!'), findsOneWidget);

    // Verify that the button is displayed
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the button and trigger a frame
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Trigger a frame after the button is tapped

    // Verify any changes in the UI after the button is tapped (if applicable)
    // For example, you might want to check if another widget is displayed
  });
}
