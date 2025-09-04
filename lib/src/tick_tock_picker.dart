import 'package:flutter/material.dart';
import 'package:ticktock/src/ticktock_style.dart';
import 'package:ticktock/src/components/picker_columns.dart';
import 'package:ticktock/src/widgets/action_buttons.dart';
import 'package:ticktock/src/utils/time_utils.dart';

/// A customizable scrollable time picker widget with separate columns for hours, minutes, and AM/PM
/// 
/// The [TickTock] widget provides an intuitive scrolling interface for time selection,
/// with support for both 12-hour and 24-hour formats, custom styling, and infinite scrolling.
/// 
/// Example usage:
/// ```dart
/// TickTock(
///   initialTime: TimeOfDay.now(),
///   onTimeChanged: (time) => print('Time: ${time.format(context)}'),
///   style: TicktockStyle(
///     selectedTimeColor: Colors.blue,
///     use24HourFormat: false,
///   ),
/// )
/// ```
class TickTock extends StatefulWidget {
  /// The initial time to display when the picker is first shown
  final TimeOfDay initialTime;

  /// Called whenever the user scrolls and changes the selected time
  /// This callback is fired continuously during scrolling
  final ValueChanged<TimeOfDay>? onTimeChanged;

  /// Called when the user confirms their time selection using the done button
  /// Only fired when [TicktockStyle.showDoneButton] is true
  final ValueChanged<TimeOfDay>? onTimeSelected;

  /// Called when the user cancels their time selection using the cancel button
  /// Only fired when [TicktockStyle.showCancelButton] is true
  final ValueChanged<TimeOfDay>? onTimeCancelled;

  /// Style configuration for customizing the appearance and behavior of the picker
  final TicktockStyle style;

  /// The height of the picker widget in logical pixels
  /// Defaults to 200.0
  final double height;

  /// Whether to show the AM/PM selector column
  /// Only applicable when [TicktockStyle.use24HourFormat] is false
  /// Defaults to true
  final bool showAmPm;

  const TickTock({
    super.key,
    required this.initialTime,
    this.onTimeChanged,
    this.onTimeSelected,
    this.onTimeCancelled,
    this.style = const TicktockStyle(),
    this.height = 200.0,
    this.showAmPm = true,
  });

  @override
  State<TickTock> createState() => _TickTockState();
}

/// Internal state management for the TickTock picker widget
class _TickTockState extends State<TickTock> {
  // Controllers for managing scroll position of each column
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;

  // Current state tracking
  late TimeOfDay _selectedTime;
  late bool _isAm;

  @override
  void initState() {
    super.initState();
    _initializeState();
    _initializeControllers();
  }

  /// Initialize the time state based on the provided initial time
  void _initializeState() {
    _selectedTime = widget.initialTime;
    _isAm = _selectedTime.period == DayPeriod.am;
  }

  /// Initialize scroll controllers with correct initial positions
  void _initializeControllers() {
    final hourIndex = TimeUtils.calculateInitialHourIndex(_selectedTime, widget.style.use24HourFormat);
    final hourItemCount = widget.style.use24HourFormat ? 24 : 12;
    
    // Calculate initial positions, accounting for infinite scroll
    final hourInitialIndex = TimeUtils.calculateInitialScrollIndex(
      hourIndex, 
      hourItemCount, 
      widget.style.infiniteScroll,
    );

    final minuteInitialIndex = TimeUtils.calculateInitialScrollIndex(
      _selectedTime.minute, 
      60, 
      widget.style.infiniteScroll,
    );

    final periodInitialIndex = _isAm ? 0 : 1;

    _hourController = FixedExtentScrollController(initialItem: hourInitialIndex);
    _minuteController = FixedExtentScrollController(initialItem: minuteInitialIndex);
    _periodController = FixedExtentScrollController(initialItem: periodInitialIndex);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: _buildContainerDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildPickerRow()),
          if (widget.style.showDoneButton || widget.style.showCancelButton)
            ActionButtons(
              style: widget.style,
              selectedTime: _selectedTime,
              onTimeSelected: widget.onTimeSelected,
              onTimeCancelled: widget.onTimeCancelled,
            ),
        ],
      ),
    );
  }

  /// Build the container decoration with styling from [TicktockStyle]
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: widget.style.backgroundColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(25),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Build the main row containing all picker columns
  Widget _buildPickerRow() {
    return Row(
      children: [
        // Hour picker column
        Expanded(
          child: HourPicker(
            controller: _hourController,
            style: widget.style,
            onSelectedItemChanged: _onHourChanged,
            height: widget.height,
          ),
        ),
        
        // Visual separator
        PickerSeparator(style: widget.style, height: widget.height),
        
        // Minute picker column
        Expanded(
          child: MinutePicker(
            controller: _minuteController,
            style: widget.style,
            onSelectedItemChanged: _onMinuteChanged,
            height: widget.height,
          ),
        ),
        
        // AM/PM picker column (conditional)
        if (_shouldShowPeriodPicker()) ...[
          PickerSeparator(style: widget.style, height: widget.height),
          Expanded(
            flex: 1,
            child: PeriodPicker(
              controller: _periodController,
              style: widget.style,
              onSelectedItemChanged: _onPeriodChanged,
              height: widget.height,
            ),
          ),
        ],
      ],
    );
  }

  /// Determine whether to show the AM/PM period picker
  bool _shouldShowPeriodPicker() {
    return !widget.style.use24HourFormat && widget.showAmPm;
  }

  /// Handle changes to the hour selection
  void _onHourChanged(int index) {
    final newHour = TimeUtils.calculateHourFromIndex(index, _isAm, widget.style.use24HourFormat);

    setState(() {
      _selectedTime = _selectedTime.replacing(hour: newHour);
    });

    widget.onTimeChanged?.call(_selectedTime);
  }

  /// Handle changes to the minute selection
  void _onMinuteChanged(int index) {
    setState(() {
      _selectedTime = _selectedTime.replacing(minute: index);
    });

    widget.onTimeChanged?.call(_selectedTime);
  }

  /// Handle changes to the AM/PM period selection
  void _onPeriodChanged(int index) {
    setState(() {
      _isAm = index == 0;
      final newHour = TimeUtils.calculateHourOnPeriodChange(_selectedTime, _isAm);
      _selectedTime = _selectedTime.replacing(hour: newHour);
    });

    widget.onTimeChanged?.call(_selectedTime);
  }
}
