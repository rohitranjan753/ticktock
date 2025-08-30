import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'clock_style.dart';

/// A customizable clock picker widget with dial interface
class ClockPicker extends StatefulWidget {
  /// Initial time to display
  final TimeOfDay initialTime;
  
  /// Callback when time is selected
  final ValueChanged<TimeOfDay>? onTimeChanged;
  
  /// Style configuration for the clock
  final ClockStyle style;
  
  /// Size of the clock widget
  final double size;
  
  /// Whether the clock is interactive
  final bool isInteractive;

  const ClockPicker({
    super.key,
    required this.initialTime,
    this.onTimeChanged,
    this.style = const ClockStyle(),
    this.size = 300.0,
    this.isInteractive = true,
  });

  @override
  State<ClockPicker> createState() => _ClockPickerState();
}

class _ClockPickerState extends State<ClockPicker> {
  late TimeOfDay _selectedTime;
  bool _isSelectingHour = true;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.style.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: GestureDetector(
        onPanUpdate: widget.isInteractive ? _onPanUpdate : null,
        onTapUp: widget.isInteractive ? _onTapUp : null,
        child: CustomPaint(
          painter: _ClockPainter(
            time: _selectedTime,
            style: widget.style,
            isSelectingHour: _isSelectingHour,
          ),
          size: Size(widget.size, widget.size),
        ),
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _updateTimeFromPosition(details.localPosition);
  }

  void _onTapUp(TapUpDetails details) {
    _updateTimeFromPosition(details.localPosition);
    // Toggle between hour and minute selection
    setState(() {
      _isSelectingHour = !_isSelectingHour;
    });
  }

  void _updateTimeFromPosition(Offset position) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final radius = widget.size / 2 - 40;
    
    final offset = position - center;
    final angle = math.atan2(offset.dy, offset.dx);
    final normalizedAngle = (angle + math.pi / 2) % (2 * math.pi);
    
    if (_isSelectingHour) {
      final hour = ((normalizedAngle / (2 * math.pi)) * 12).round() % 12;
      final adjustedHour = widget.style.use24HourFormat 
          ? (offset.distance < radius * 0.7 ? hour + 12 : hour)
          : hour;
      
      setState(() {
        _selectedTime = _selectedTime.replacing(
          hour: adjustedHour == 0 && !widget.style.use24HourFormat ? 12 : adjustedHour,
        );
      });
    } else {
      final minute = ((normalizedAngle / (2 * math.pi)) * 60).round() % 60;
      setState(() {
        _selectedTime = _selectedTime.replacing(minute: minute);
      });
    }
    
    widget.onTimeChanged?.call(_selectedTime);
  }
}

class _ClockPainter extends CustomPainter {
  final TimeOfDay time;
  final ClockStyle style;
  final bool isSelectingHour;

  _ClockPainter({
    required this.time,
    required this.style,
    required this.isSelectingHour,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 40;

    // Draw clock face
    _drawClockFace(canvas, center, radius);
    
    // Draw hour markers and numbers
    _drawHourMarkers(canvas, center, radius);
    
    // Draw minute markers
    if (style.showMinuteMarkers) {
      _drawMinuteMarkers(canvas, center, radius);
    }
    
    // Draw clock hands
    _drawClockHands(canvas, center, radius);
    
    // Draw center dot
    _drawCenterDot(canvas, center);
    
    // Draw selection indicator
    _drawSelectionIndicator(canvas, center, radius);
  }

  void _drawClockFace(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = style.dialColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius, paint);
    
    final borderPaint = Paint()
      ..color = style.dialColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    canvas.drawCircle(center, radius, borderPaint);
  }

  void _drawHourMarkers(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = style.hourMarkerColor
      ..strokeWidth = style.hourMarkerSize
      ..strokeCap = StrokeCap.round;

    for (int i = 1; i <= 12; i++) {
      final angle = (i * 30 - 90) * math.pi / 180;
      final startPoint = center + Offset(
        math.cos(angle) * (radius - 20),
        math.sin(angle) * (radius - 20),
      );
      final endPoint = center + Offset(
        math.cos(angle) * (radius - 5),
        math.sin(angle) * (radius - 5),
      );
      
      canvas.drawLine(startPoint, endPoint, paint);
      
      if (style.showHourNumbers) {
        _drawHourNumber(canvas, center, radius, i, angle);
      }
    }
  }

  void _drawHourNumber(Canvas canvas, Offset center, double radius, int hour, double angle) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: hour.toString(),
        style: style.hourTextStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    
    final numberPosition = center + Offset(
      math.cos(angle) * (radius - 35) - textPainter.width / 2,
      math.sin(angle) * (radius - 35) - textPainter.height / 2,
    );
    
    textPainter.paint(canvas, numberPosition);
  }

  void _drawMinuteMarkers(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = style.minuteMarkerColor
      ..strokeWidth = style.minuteMarkerSize
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 60; i++) {
      if (i % 5 != 0) { // Skip hour positions
        final angle = (i * 6 - 90) * math.pi / 180;
        final startPoint = center + Offset(
          math.cos(angle) * (radius - 15),
          math.sin(angle) * (radius - 15),
        );
        final endPoint = center + Offset(
          math.cos(angle) * (radius - 5),
          math.sin(angle) * (radius - 5),
        );
        
        canvas.drawLine(startPoint, endPoint, paint);
      }
    }
  }

  void _drawClockHands(Canvas canvas, Offset center, double radius) {
    // Hour hand
    final hourAngle = ((time.hour % 12) * 30 + time.minute * 0.5 - 90) * math.pi / 180;
    final hourEnd = center + Offset(
      math.cos(hourAngle) * (radius * 0.5),
      math.sin(hourAngle) * (radius * 0.5),
    );
    
    final hourPaint = Paint()
      ..color = style.hourHandColor
      ..strokeWidth = style.hourHandWidth
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(center, hourEnd, hourPaint);
    
    // Minute hand
    final minuteAngle = (time.minute * 6 - 90) * math.pi / 180;
    final minuteEnd = center + Offset(
      math.cos(minuteAngle) * (radius * 0.7),
      math.sin(minuteAngle) * (radius * 0.7),
    );
    
    final minutePaint = Paint()
      ..color = style.minuteHandColor
      ..strokeWidth = style.minuteHandWidth
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(center, minuteEnd, minutePaint);
  }

  void _drawCenterDot(Canvas canvas, Offset center) {
    final paint = Paint()
      ..color = style.centerDotColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, style.centerDotSize / 2, paint);
  }

  void _drawSelectionIndicator(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = style.selectedTimeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    if (isSelectingHour) {
      // Highlight hour selection
      final hourAngle = ((time.hour % 12) * 30 - 90) * math.pi / 180;
      final hourPosition = center + Offset(
        math.cos(hourAngle) * (radius - 35),
        math.sin(hourAngle) * (radius - 35),
      );
      canvas.drawCircle(hourPosition, 20, paint);
    } else {
      // Highlight minute selection
      final minuteAngle = (time.minute * 6 - 90) * math.pi / 180;
      final minutePosition = center + Offset(
        math.cos(minuteAngle) * (radius - 10),
        math.sin(minuteAngle) * (radius - 10),
      );
      canvas.drawCircle(minutePosition, 15, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}