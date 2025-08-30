import 'package:flutter/material.dart';

/// Configuration class for customizing the appearance of the clock picker
class ClockStyle {
  /// Color of the clock dial
  final Color dialColor;
  
  /// Color of the hour markers
  final Color hourMarkerColor;
  
  /// Color of the minute markers
  final Color minuteMarkerColor;
  
  /// Color of the hour hand
  final Color hourHandColor;
  
  /// Color of the minute hand
  final Color minuteHandColor;
  
  /// Color of the center dot
  final Color centerDotColor;
  
  /// Background color of the clock face
  final Color backgroundColor;
  
  /// Color of the selected time highlight
  final Color selectedTimeColor;
  
  /// Text style for hour numbers
  final TextStyle hourTextStyle;
  
  /// Text style for the selected time display
  final TextStyle selectedTimeTextStyle;
  
  /// Width of the hour hand
  final double hourHandWidth;
  
  /// Width of the minute hand
  final double minuteHandWidth;
  
  /// Size of the center dot
  final double centerDotSize;
  
  /// Size of hour markers
  final double hourMarkerSize;
  
  /// Size of minute markers
  final double minuteMarkerSize;
  
  /// Whether to show hour numbers
  final bool showHourNumbers;
  
  /// Whether to show minute markers
  final bool showMinuteMarkers;
  
  /// Whether to use 24-hour format
  final bool use24HourFormat;

  const ClockStyle({
    this.dialColor = Colors.blue,
    this.hourMarkerColor = Colors.black87,
    this.minuteMarkerColor = Colors.grey,
    this.hourHandColor = Colors.black87,
    this.minuteHandColor = Colors.black54,
    this.centerDotColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.selectedTimeColor = Colors.blue,
    this.hourTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    this.selectedTimeTextStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    this.hourHandWidth = 4.0,
    this.minuteHandWidth = 2.0,
    this.centerDotSize = 8.0,
    this.hourMarkerSize = 3.0,
    this.minuteMarkerSize = 1.0,
    this.showHourNumbers = true,
    this.showMinuteMarkers = true,
    this.use24HourFormat = false,
  });

  /// Create a copy of this style with the given fields replaced
  ClockStyle copyWith({
    Color? dialColor,
    Color? hourMarkerColor,
    Color? minuteMarkerColor,
    Color? hourHandColor,
    Color? minuteHandColor,
    Color? centerDotColor,
    Color? backgroundColor,
    Color? selectedTimeColor,
    TextStyle? hourTextStyle,
    TextStyle? selectedTimeTextStyle,
    double? hourHandWidth,
    double? minuteHandWidth,
    double? centerDotSize,
    double? hourMarkerSize,
    double? minuteMarkerSize,
    bool? showHourNumbers,
    bool? showMinuteMarkers,
    bool? use24HourFormat,
  }) {
    return ClockStyle(
      dialColor: dialColor ?? this.dialColor,
      hourMarkerColor: hourMarkerColor ?? this.hourMarkerColor,
      minuteMarkerColor: minuteMarkerColor ?? this.minuteMarkerColor,
      hourHandColor: hourHandColor ?? this.hourHandColor,
      minuteHandColor: minuteHandColor ?? this.minuteHandColor,
      centerDotColor: centerDotColor ?? this.centerDotColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedTimeColor: selectedTimeColor ?? this.selectedTimeColor,
      hourTextStyle: hourTextStyle ?? this.hourTextStyle,
      selectedTimeTextStyle: selectedTimeTextStyle ?? this.selectedTimeTextStyle,
      hourHandWidth: hourHandWidth ?? this.hourHandWidth,
      minuteHandWidth: minuteHandWidth ?? this.minuteHandWidth,
      centerDotSize: centerDotSize ?? this.centerDotSize,
      hourMarkerSize: hourMarkerSize ?? this.hourMarkerSize,
      minuteMarkerSize: minuteMarkerSize ?? this.minuteMarkerSize,
      showHourNumbers: showHourNumbers ?? this.showHourNumbers,
      showMinuteMarkers: showMinuteMarkers ?? this.showMinuteMarkers,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
    );
  }
}