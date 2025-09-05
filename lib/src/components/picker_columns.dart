import 'package:flutter/material.dart';
import 'package:ticktock/src/ticktock_style.dart';
import 'package:ticktock/src/widgets/scroll_wheel.dart';
import 'package:ticktock/src/utils/time_utils.dart';

/// Hour picker column component
class HourPicker extends StatelessWidget {
  final FixedExtentScrollController controller;
  final TicktockStyle style;
  final ValueChanged<int> onSelectedItemChanged;
  final double height;

  const HourPicker({
    super.key,
    required this.controller,
    required this.style,
    required this.onSelectedItemChanged,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollWheel(
      controller: controller,
      itemCount: style.use24HourFormat ? 24 : 12,
      itemBuilder: (index) =>
          TimeUtils.buildHourLabel(index, style.use24HourFormat),
      onSelectedItemChanged: onSelectedItemChanged,
      label: style.hourLabelText,
      labelStyle: style.hourLabelTextStyle,
      isInfinite: style.infiniteScroll,
      style: style,
      height: height,
    );
  }
}

/// Minute picker column component
class MinutePicker extends StatelessWidget {
  final FixedExtentScrollController controller;
  final TicktockStyle style;
  final ValueChanged<int> onSelectedItemChanged;
  final double height;

  const MinutePicker({
    super.key,
    required this.controller,
    required this.style,
    required this.onSelectedItemChanged,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollWheel(
      controller: controller,
      itemCount: 60,
      itemBuilder: (index) => index.toString().padLeft(2, '0'),
      onSelectedItemChanged: onSelectedItemChanged,
      label: style.minuteLabelText,
      labelStyle: style.minuteLabelTextStyle,
      isInfinite: style.infiniteScroll,
      style: style,
      height: height,
    );
  }
}

/// AM/PM period picker column component
class PeriodPicker extends StatelessWidget {
  final FixedExtentScrollController controller;
  final TicktockStyle style;
  final ValueChanged<int> onSelectedItemChanged;
  final double height;

  const PeriodPicker({
    super.key,
    required this.controller,
    required this.style,
    required this.onSelectedItemChanged,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollWheel(
      controller: controller,
      itemCount: 2,
      itemBuilder: (index) => index == 0 ? 'AM' : 'PM',
      onSelectedItemChanged: onSelectedItemChanged,
      label: style.periodLabelText,
      labelStyle: style.periodLabelTextStyle,
      isInfinite: false,
      style: style,
      height: height,
    );
  }
}
