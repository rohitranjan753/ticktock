import 'package:flutter/material.dart';
import 'package:ticktock/src/ticktock_style.dart';

/// Action buttons component for Done/Cancel functionality
class ActionButtons extends StatelessWidget {
  final TicktockStyle style;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final ValueChanged<TimeOfDay>? onTimeCancelled;

  const ActionButtons({
    super.key,
    required this.style,
    required this.selectedTime,
    this.onTimeSelected,
    this.onTimeCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (style.showCancelButton) _buildCancelButton(),
        if (style.showDoneButton) _buildDoneButton(),
      ],
    );
  }

  /// Build the cancel button
  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => onTimeCancelled?.call(selectedTime),
      child: Text(style.cancelButtonText, style: style.cancelButtonTextStyle),
    );
  }

  /// Build the done button
  Widget _buildDoneButton() {
    return TextButton(
      onPressed: () => onTimeSelected?.call(selectedTime),
      child: Text(style.doneButtonText, style: style.doneButtonTextStyle),
    );
  }
}

/// Visual separator between picker columns
class PickerSeparator extends StatelessWidget {
  final TicktockStyle style;
  final double height;

  const PickerSeparator({super.key, required this.style, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: height * 0.6,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: style.dialColor.withAlpha(75),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
