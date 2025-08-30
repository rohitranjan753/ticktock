import 'package:flutter/material.dart';
import 'package:ticktock/ticktock.dart';

/// A scrollable time picker widget with separate hour and minute columns
class TimeScrollPicker extends StatefulWidget {
  /// Initial time to display
  final TimeOfDay initialTime;
  
  /// Callback when time is selected
  final ValueChanged<TimeOfDay>? onTimeChanged;
  
  /// Style configuration for the picker
  final ClockStyle style;
  
  /// Height of the picker widget
  final double height;
  
  /// Whether to show AM/PM selector
  final bool showAmPm;

  const TimeScrollPicker({
    super.key,
    required this.initialTime,
    this.onTimeChanged,
    this.style = const ClockStyle(),
    this.height = 200.0,
    this.showAmPm = true,
  });

  @override
  State<TimeScrollPicker> createState() => _TimeScrollPickerState();
}

class _TimeScrollPickerState extends State<TimeScrollPicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;
  
  late TimeOfDay _selectedTime;
  late bool _isAm;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _isAm = _selectedTime.period == DayPeriod.am;
    
    final hourIndex = widget.style.use24HourFormat 
        ? _selectedTime.hour 
        : (_selectedTime.hourOfPeriod == 0 ? 12 : _selectedTime.hourOfPeriod) - 1;
    
    _hourController = FixedExtentScrollController(initialItem: hourIndex);
    _minuteController = FixedExtentScrollController(initialItem: _selectedTime.minute);
    _periodController = FixedExtentScrollController(initialItem: _isAm ? 0 : 1);
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
      decoration: BoxDecoration(
        color: widget.style.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Hour picker
          Expanded(
            child: _buildScrollWheel(
              controller: _hourController,
              itemCount: widget.style.use24HourFormat ? 24 : 12,
              itemBuilder: (index) => widget.style.use24HourFormat 
                  ? index.toString().padLeft(2, '0')
                  : (index + 1).toString(),
              onSelectedItemChanged: _onHourChanged,
              label: 'Hour',
            ),
          ),
          
          // Separator
          _buildSeparator(),
          
          // Minute picker
          Expanded(
            child: _buildScrollWheel(
              controller: _minuteController,
              itemCount: 60,
              itemBuilder: (index) => index.toString().padLeft(2, '0'),
              onSelectedItemChanged: _onMinuteChanged,
              label: 'Minute',
            ),
          ),
          
          // AM/PM picker (if not 24-hour format)
          if (!widget.style.use24HourFormat && widget.showAmPm) ...[
            _buildSeparator(),
            Expanded(
              flex: 1,
              child: _buildScrollWheel(
                controller: _periodController,
                itemCount: 2,
                itemBuilder: (index) => index == 0 ? 'AM' : 'PM',
                onSelectedItemChanged: _onPeriodChanged,
                label: 'Period',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScrollWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required String label,
  }) {
    return Column(
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: widget.style.hourTextStyle.copyWith(
              fontSize: 12,
              color: widget.style.hourTextStyle.color?.withValues(alpha: 0.6),
            ),
          ),
        ),
        
        // Scroll wheel
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onSelectedItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: itemCount,
              builder: (context, index) {
                return Center(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      final isSelected = controller.hasClients && 
                          controller.selectedItem == index;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? widget.style.selectedTimeColor.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          itemBuilder(index),
                          style: widget.style.selectedTimeTextStyle.copyWith(
                            color: isSelected 
                                ? widget.style.selectedTimeColor
                                : widget.style.hourTextStyle.color,
                            fontSize: isSelected ? 20 : 16,
                            fontWeight: isSelected 
                                ? FontWeight.bold 
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 2,
      height: widget.height * 0.6,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: widget.style.dialColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  void _onHourChanged(int index) {
    final hour = widget.style.use24HourFormat 
        ? index 
        : (index + 1) + (_isAm ? 0 : 12);
    
    setState(() {
      _selectedTime = _selectedTime.replacing(
        hour: widget.style.use24HourFormat 
            ? hour 
            : (hour % 12 == 0 ? (_isAm ? 0 : 12) : hour % 12),
      );
    });
    
    widget.onTimeChanged?.call(_selectedTime);
  }

  void _onMinuteChanged(int index) {
    setState(() {
      _selectedTime = _selectedTime.replacing(minute: index);
    });
    
    widget.onTimeChanged?.call(_selectedTime);
  }

  void _onPeriodChanged(int index) {
    setState(() {
      _isAm = index == 0;
      final newHour = _isAm 
          ? (_selectedTime.hour > 12 ? _selectedTime.hour - 12 : _selectedTime.hour)
          : (_selectedTime.hour < 12 ? _selectedTime.hour + 12 : _selectedTime.hour);
      
      _selectedTime = _selectedTime.replacing(hour: newHour == 0 ? 12 : newHour);
    });
    
    widget.onTimeChanged?.call(_selectedTime);
  }
}

/// A combined widget that shows both clock dial and scroll picker
class CombinedTimePicker extends StatefulWidget {
  /// Initial time to display
  final TimeOfDay initialTime;
  
  /// Callback when time is selected
  final ValueChanged<TimeOfDay>? onTimeChanged;
  
  /// Style configuration for both pickers
  final ClockStyle style;
  
  /// Size of the clock widget
  final double clockSize;
  
  /// Height of the scroll picker
  final double scrollHeight;
  
  /// Layout orientation
  final Axis orientation;

  const CombinedTimePicker({
    super.key,
    required this.initialTime,
    this.onTimeChanged,
    this.style = const ClockStyle(),
    this.clockSize = 250.0,
    this.scrollHeight = 150.0,
    this.orientation = Axis.vertical,
  });

  @override
  State<CombinedTimePicker> createState() => _CombinedTimePickerState();
}

class _CombinedTimePickerState extends State<CombinedTimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    final clockPicker = ClockPicker(
      initialTime: _selectedTime,
      onTimeChanged: _onTimeChanged,
      style: widget.style,
      size: widget.clockSize,
    );
    
    final scrollPicker = TimeScrollPicker(
      initialTime: _selectedTime,
      onTimeChanged: _onTimeChanged,
      style: widget.style,
      height: widget.scrollHeight,
    );

    return widget.orientation == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              clockPicker,
              const SizedBox(height: 20),
              scrollPicker,
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              clockPicker,
              const SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: scrollPicker,
              ),
            ],
          );
  }

  void _onTimeChanged(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
    widget.onTimeChanged?.call(time);
  }
}