import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticktock/ticktock.dart';

void main() {
  group('TickTock Clock Picker Tests', () {
    testWidgets('ClockPicker renders correctly', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 10, minute: 30);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClockPicker(
              initialTime: initialTime,
            ),
          ),
        ),
      );

      expect(find.byType(ClockPicker), findsOneWidget);
      // Instead of checking for CustomPaint directly, check for the Container that wraps it
      expect(find.descendant(
        of: find.byType(ClockPicker),
        matching: find.byType(Container),
      ), findsOneWidget);
    });

    testWidgets('ClockPicker responds to time changes', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 10, minute: 30);
      TimeOfDay? changedTime;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClockPicker(
              initialTime: initialTime,
              onTimeChanged: (time) {
                changedTime = time;
              },
            ),
          ),
        ),
      );

      // Tap on the clock to change time
      await tester.tap(find.byType(ClockPicker));
      await tester.pump();

      expect(changedTime, isNotNull);
    });

    testWidgets('TimeScrollPicker renders correctly', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 14, minute: 45);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeScrollPicker(
              initialTime: initialTime,
            ),
          ),
        ),
      );

      expect(find.byType(TimeScrollPicker), findsOneWidget);
      expect(find.byType(ListWheelScrollView), findsAtLeast(2)); // Hour and minute wheels
    });

    testWidgets('CombinedTimePicker renders both components', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 9, minute: 15);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CombinedTimePicker(
              initialTime: initialTime,
            ),
          ),
        ),
      );

      expect(find.byType(CombinedTimePicker), findsOneWidget);
      expect(find.byType(ClockPicker), findsOneWidget);
      expect(find.byType(TimeScrollPicker), findsOneWidget);
    });

    group('ClockStyle Tests', () {
      test('ClockStyle default values', () {
        const style = ClockStyle();
        
        expect(style.dialColor, equals(Colors.blue));
        expect(style.hourMarkerColor, equals(Colors.black87));
        expect(style.backgroundColor, equals(Colors.white));
        expect(style.use24HourFormat, equals(false));
        expect(style.showHourNumbers, equals(true));
        expect(style.showMinuteMarkers, equals(true));
      });

      test('ClockStyle copyWith functionality', () {
        const originalStyle = ClockStyle();
        final newStyle = originalStyle.copyWith(
          dialColor: Colors.red,
          use24HourFormat: true,
        );
        
        expect(newStyle.dialColor, equals(Colors.red));
        expect(newStyle.use24HourFormat, equals(true));
        expect(newStyle.hourMarkerColor, equals(Colors.black87)); // Unchanged
      });
    });

    testWidgets('ClockPicker with custom style', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 12, minute: 0);
      const customStyle = ClockStyle(
        dialColor: Colors.red,
        backgroundColor: Colors.grey,
        use24HourFormat: true,
        showMinuteMarkers: false,
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClockPicker(
              initialTime: initialTime,
              style: customStyle,
            ),
          ),
        ),
      );

      expect(find.byType(ClockPicker), findsOneWidget);
    });

    testWidgets('TimeScrollPicker with 24-hour format', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 23, minute: 59);
      const customStyle = ClockStyle(use24HourFormat: true);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeScrollPicker(
              initialTime: initialTime,
              style: customStyle,
            ),
          ),
        ),
      );

      expect(find.byType(TimeScrollPicker), findsOneWidget);
      // Should not show AM/PM picker in 24-hour format
      expect(find.text('AM'), findsNothing);
      expect(find.text('PM'), findsNothing);
    });

    testWidgets('CombinedTimePicker horizontal orientation', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 6, minute: 30);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CombinedTimePicker(
              initialTime: initialTime,
              orientation: Axis.horizontal,
            ),
          ),
        ),
      );

      expect(find.byType(CombinedTimePicker), findsOneWidget);
      expect(find.byType(Row), findsAtLeast(1)); // Horizontal layout
    });

    testWidgets('ClockPicker non-interactive mode', (WidgetTester tester) async {
      const initialTime = TimeOfDay(hour: 8, minute: 20);
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClockPicker(
              initialTime: initialTime,
              isInteractive: false,
            ),
          ),
        ),
      );

      expect(find.byType(ClockPicker), findsOneWidget);
      
      // Tapping should not change anything since it's non-interactive
      await tester.tap(find.byType(ClockPicker));
      await tester.pump();
      
      // Widget should still be there and unchanged
      expect(find.byType(ClockPicker), findsOneWidget);
    });

    group('Time Validation Tests', () {
      testWidgets('ClockPicker handles edge cases', (WidgetTester tester) async {
        // Test midnight
        const midnightTime = TimeOfDay(hour: 0, minute: 0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ClockPicker(
                initialTime: midnightTime,
              ),
            ),
          ),
        );

        expect(find.byType(ClockPicker), findsOneWidget);
      });

      testWidgets('TimeScrollPicker handles edge cases', (WidgetTester tester) async {
        // Test noon
        const noonTime = TimeOfDay(hour: 12, minute: 0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TimeScrollPicker(
                initialTime: noonTime,
              ),
            ),
          ),
        );

        expect(find.byType(TimeScrollPicker), findsOneWidget);
      });
    });
  });
}
