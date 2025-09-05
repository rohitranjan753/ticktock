import 'package:flutter/material.dart';

/// Utility class for time-related calculations and conversions
class TimeUtils {
  /// Calculate the correct hour index for the scroll controller
  static int calculateInitialHourIndex(TimeOfDay time, bool use24HourFormat) {
    if (use24HourFormat) {
      return time.hour;
    } else {
      // Convert to 12-hour format (1-12)
      final hourOfPeriod = time.hourOfPeriod;
      return (hourOfPeriod == 0 ? 12 : hourOfPeriod) - 1;
    }
  }

  /// Build hour labels based on the current format
  static String buildHourLabel(int index, bool use24HourFormat) {
    if (use24HourFormat) {
      return index.toString().padLeft(2, '0');
    } else {
      return (index + 1).toString(); // 1-12 format
    }
  }

  /// Calculate the hour value from scroll index and period
  static int calculateHourFromIndex(
    int index,
    bool isAm,
    bool use24HourFormat,
  ) {
    if (use24HourFormat) {
      return index;
    } else {
      // Convert 12-hour picker index (0-11) to actual hour
      final displayHour = index + 1; // 1-12

      if (isAm) {
        // AM: 12 becomes 0, 1-11 stay the same
        return displayHour == 12 ? 0 : displayHour;
      } else {
        // PM: 12 stays 12, 1-11 become 13-23
        return displayHour == 12 ? 12 : displayHour + 12;
      }
    }
  }

  /// Calculate new hour when period (AM/PM) changes
  static int calculateHourOnPeriodChange(TimeOfDay currentTime, bool isAm) {
    final currentHour = currentTime.hour;

    if (isAm) {
      // Switching to AM: if hour is 12-23, subtract 12
      return currentHour >= 12 ? currentHour - 12 : currentHour;
    } else {
      // Switching to PM: if hour is 0-11, add 12
      return currentHour < 12 ? currentHour + 12 : currentHour;
    }
  }

  /// Calculate initial scroll positions with infinite scroll support
  static int calculateInitialScrollIndex(
    int baseIndex,
    int itemCount,
    bool infiniteScroll,
  ) {
    return infiniteScroll ? (itemCount * 500) + baseIndex : baseIndex;
  }
}
