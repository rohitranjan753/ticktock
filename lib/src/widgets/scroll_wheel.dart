import 'package:flutter/material.dart';
import 'package:ticktock/src/ticktock_style.dart';

/// A reusable scroll wheel widget for selecting values
class ScrollWheel extends StatelessWidget {
  final FixedExtentScrollController controller;
  final int itemCount;
  final String Function(int) itemBuilder;
  final ValueChanged<int> onSelectedItemChanged;
  final String label;
  final TextStyle? labelStyle;
  final bool isInfinite;
  final TicktockStyle style;
  final double height;

  const ScrollWheel({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    required this.onSelectedItemChanged,
    required this.label,
    this.labelStyle,
    required this.isInfinite,
    required this.style,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final int infiniteItemCount = isInfinite ? itemCount * 1000 : itemCount;

    return Column(
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style:
                labelStyle ??
                style.hourTextStyle.copyWith(
                  fontSize: 12,
                  color: style.hourTextStyle.color?.withAlpha(150),
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
            onSelectedItemChanged: (index) {
              final actualIndex = isInfinite ? index % itemCount : index;
              onSelectedItemChanged(actualIndex);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: infiniteItemCount,
              builder: (context, index) {
                final actualIndex = isInfinite ? index % itemCount : index;

                return Center(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      final isSelected =
                          controller.hasClients &&
                          (isInfinite
                              ? controller.selectedItem % itemCount ==
                                    actualIndex
                              : controller.selectedItem == index);

                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? style.selectedTimeColor.withAlpha(25)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          itemBuilder(actualIndex),
                          style: style.selectedTimeTextStyle.copyWith(
                            color: isSelected
                                ? style.selectedTimeColor
                                : style.hourTextStyle.color,
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
}
