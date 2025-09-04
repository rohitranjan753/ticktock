import 'package:flutter/material.dart';

/// Configuration class for customizing the appearance and behavior of the TickTock picker
///
/// The [TicktockStyle] class provides comprehensive styling options for all visual
/// aspects of the time picker, including colors, text styles, layout options, and
/// interactive behavior settings.
///
/// Example usage:
/// ```dart
/// TicktockStyle(
///   selectedTimeColor: Colors.blue,
///   backgroundColor: Colors.white,
///   use24HourFormat: false,
///   infiniteScroll: true,
///   hourLabelText: 'Hours',
///   minuteLabelText: 'Minutes',
///   showDoneButton: true,
/// )
/// ```
class TicktockStyle {
  // ==================== Visual Colors ====================

  /// Color of the clock dial border and visual elements
  /// Used for separators and accent elements throughout the picker
  final Color dialColor;

  /// Color of the hour markers on clock faces
  /// Currently used for visual consistency across components
  final Color hourMarkerColor;

  /// Color of the minute markers on clock faces
  /// Currently used for visual consistency across components
  final Color minuteMarkerColor;

  /// Color of the hour hand on clock faces
  /// Currently used for visual consistency across components
  final Color hourHandColor;

  /// Color of the minute hand on clock faces
  /// Currently used for visual consistency across components
  final Color minuteHandColor;

  /// Color of the center dot on clock faces
  /// Currently used for visual consistency across components
  final Color centerDotColor;

  /// Background color of the picker container
  /// Applied to the main picker widget background
  final Color backgroundColor;

  /// Color used for highlighting selected time values
  /// Applied to selected items in scroll wheels and selection indicators
  final Color selectedTimeColor;

  // ==================== Text Styling ====================

  /// Text style for hour numbers and general text elements
  /// Used as base styling for unselected items in the picker
  final TextStyle hourTextStyle;

  /// Text style for selected time display
  /// Applied to currently selected items in scroll wheels
  final TextStyle selectedTimeTextStyle;

  // ==================== Physical Dimensions ====================

  /// Width of the hour hand in logical pixels
  /// Currently used for visual consistency, may be used in future clock face implementations
  final double hourHandWidth;

  /// Width of the minute hand in logical pixels
  /// Currently used for visual consistency, may be used in future clock face implementations
  final double minuteHandWidth;

  /// Size of the center dot in logical pixels
  /// Currently used for visual consistency, may be used in future clock face implementations
  final double centerDotSize;

  /// Size of hour markers in logical pixels
  /// Currently used for visual consistency, may be used in future clock face implementations
  final double hourMarkerSize;

  /// Size of minute markers in logical pixels
  /// Currently used for visual consistency, may be used in future clock face implementations
  final double minuteMarkerSize;

  // ==================== Display Options ====================

  /// Whether to show hour numbers on clock faces
  /// Currently used for visual consistency, may be used in future clock face implementations
  final bool showHourNumbers;

  /// Whether to show minute markers on clock faces
  /// Currently used for visual consistency, may be used in future clock face implementations
  final bool showMinuteMarkers;

  /// Whether to use 24-hour format (00-23) instead of 12-hour format (1-12 + AM/PM)
  /// When true, hours display 00-23 and AM/PM selector is hidden
  final bool use24HourFormat;

  /// Whether to enable infinite scrolling for hour and minute pickers
  /// When true, users can scroll continuously in either direction
  /// When false, scrolling stops at the first/last item
  final bool infiniteScroll;

  // ==================== Action Buttons ====================

  /// Whether to show the Done/Confirm button
  /// When true, displays a button that triggers [TickTock.onTimeSelected]
  final bool showDoneButton;

  /// Whether to show the Cancel/Discard button
  /// When true, displays a button that triggers [TickTock.onTimeCancelled]
  final bool showCancelButton;

  /// Text displayed on the Done/Confirm button
  /// Only visible when [showDoneButton] is true
  final String doneButtonText;

  /// Text style for the Done/Confirm button
  /// Applied to [doneButtonText]
  final TextStyle doneButtonTextStyle;

  /// Text displayed on the Cancel/Discard button
  /// Only visible when [showCancelButton] is true
  final String cancelButtonText;

  /// Text style for the Cancel/Discard button
  /// Applied to [cancelButtonText]
  final TextStyle cancelButtonTextStyle;

  // ==================== Column Labels ====================

  /// Custom text for the hour column label
  /// Displayed above the hour picker column
  final String hourLabelText;

  /// Custom text for the minute column label
  /// Displayed above the minute picker column
  final String minuteLabelText;

  /// Custom text for the AM/PM period column label
  /// Displayed above the period picker column (only in 12-hour format)
  final String periodLabelText;

  /// Text style for the hour column label
  /// Applied to [hourLabelText]
  final TextStyle hourLabelTextStyle;

  /// Text style for the minute column label
  /// Applied to [minuteLabelText]
  final TextStyle minuteLabelTextStyle;

  /// Text style for the period column label
  /// Applied to [periodLabelText]
  final TextStyle periodLabelTextStyle;

  // ==================== Constructor ====================

  /// Creates a new [TicktockStyle] with the specified styling options
  ///
  /// All parameters are optional and have sensible defaults for immediate use
  const TicktockStyle({
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
    this.infiniteScroll = false,
    this.showDoneButton = false,
    this.showCancelButton = false,
    this.doneButtonText = 'OK',
    this.doneButtonTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    this.cancelButtonText = 'Cancel',
    this.cancelButtonTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    this.hourLabelText = 'Hour',
    this.minuteLabelText = 'Minute',
    this.periodLabelText = 'Period',
    this.hourLabelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
    this.minuteLabelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
    this.periodLabelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
  });

  /// Create a copy of this style with the given fields replaced
  TicktockStyle copyWith({
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
    bool? infiniteScroll,
    bool? showDoneButton,
    bool? showCancelButton,
    String? doneButtonText,
    String? cancelButtonText,
    String? hourLabelText,
    String? minuteLabelText,
    String? periodLabelText,
    TextStyle? hourLabelTextStyle,
    TextStyle? minuteLabelTextStyle,
    TextStyle? periodLabelTextStyle,
  }) {
    return TicktockStyle(
      dialColor: dialColor ?? this.dialColor,
      hourMarkerColor: hourMarkerColor ?? this.hourMarkerColor,
      minuteMarkerColor: minuteMarkerColor ?? this.minuteMarkerColor,
      hourHandColor: hourHandColor ?? this.hourHandColor,
      minuteHandColor: minuteHandColor ?? this.minuteHandColor,
      centerDotColor: centerDotColor ?? this.centerDotColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedTimeColor: selectedTimeColor ?? this.selectedTimeColor,
      hourTextStyle: hourTextStyle ?? this.hourTextStyle,
      selectedTimeTextStyle:
          selectedTimeTextStyle ?? this.selectedTimeTextStyle,
      hourHandWidth: hourHandWidth ?? this.hourHandWidth,
      minuteHandWidth: minuteHandWidth ?? this.minuteHandWidth,
      centerDotSize: centerDotSize ?? this.centerDotSize,
      hourMarkerSize: hourMarkerSize ?? this.hourMarkerSize,
      minuteMarkerSize: minuteMarkerSize ?? this.minuteMarkerSize,
      showHourNumbers: showHourNumbers ?? this.showHourNumbers,
      showMinuteMarkers: showMinuteMarkers ?? this.showMinuteMarkers,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
      infiniteScroll: infiniteScroll ?? this.infiniteScroll,
      showDoneButton: showDoneButton ?? this.showDoneButton,
      showCancelButton: showCancelButton ?? this.showCancelButton,
      doneButtonText: doneButtonText ?? this.doneButtonText,
      cancelButtonText: cancelButtonText ?? this.cancelButtonText,
      hourLabelText: hourLabelText ?? this.hourLabelText,
      minuteLabelText: minuteLabelText ?? this.minuteLabelText,
      periodLabelText: periodLabelText ?? this.periodLabelText,
      hourLabelTextStyle: hourLabelTextStyle ?? this.hourLabelTextStyle,
      minuteLabelTextStyle: minuteLabelTextStyle ?? this.minuteLabelTextStyle,
      periodLabelTextStyle: periodLabelTextStyle ?? this.periodLabelTextStyle,
    );
  }
}
