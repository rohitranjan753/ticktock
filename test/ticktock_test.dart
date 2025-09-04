import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticktock/ticktock.dart';

void main() {
  group('TickTock Clock Picker Tests', () {

    testWidgets('TimeScrollPicker renders correctly', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 14, minute: 45);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickTock(
              initialTime: initialTime,
            ),
          ),
        ),
      );

      expect(find.byType(TickTock), findsOneWidget);
      expect(find.byType(ListWheelScrollView), findsAtLeast(2)); // Hour and minute wheels
    });


    group('ClockStyle Tests', () {
      test('ClockStyle default values', () {
        const style = TicktockStyle();
        
        expect(style.dialColor, equals(Colors.blue));
        expect(style.hourMarkerColor, equals(Colors.black87));
        expect(style.backgroundColor, equals(Colors.white));
        expect(style.use24HourFormat, equals(false));
        expect(style.showHourNumbers, equals(true));
        expect(style.showMinuteMarkers, equals(true));
      });

      test('ClockStyle copyWith functionality', () {
        const originalStyle = TicktockStyle();
        final newStyle = originalStyle.copyWith(
          dialColor: Colors.red,
          use24HourFormat: true,
        );
        
        expect(newStyle.dialColor, equals(Colors.red));
        expect(newStyle.use24HourFormat, equals(true));
        expect(newStyle.hourMarkerColor, equals(Colors.black87)); // Unchanged
      });
    });


    testWidgets('TimeScrollPicker with 24-hour format', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 23, minute: 59);
      const customStyle = TicktockStyle(use24HourFormat: true);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickTock(
              initialTime: initialTime,
              style: customStyle,
            ),
          ),
        ),
      );

      expect(find.byType(TickTock), findsOneWidget);
      // Should not show AM/PM picker in 24-hour format
      expect(find.text('AM'), findsNothing);
      expect(find.text('PM'), findsNothing);
    });

    group('Time Validation Tests', () {

      testWidgets('TimeScrollPicker handles edge cases', (WidgetTester tester) async {
        // Test noon
        const noonTime = TimeOfDay(hour: 12, minute: 0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TickTock(
                initialTime: noonTime,
              ),
            ),
          ),
        );

        expect(find.byType(TickTock), findsOneWidget);
      });
    });
  });
}
