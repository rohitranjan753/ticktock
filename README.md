# TickTock ⏰

A customizable clock picker widget for Flutter with both dial and scroll bar interfaces for intuitive time selection.

## Features

- 🎨 **Highly Customizable**: Extensive styling options for colors, sizes, and appearance
- 🕐 **Dual Interface**: Both traditional clock dial and modern scroll picker
- 📱 **Responsive Design**: Works beautifully on all screen sizes
- 🌍 **24-Hour Support**: Toggle between 12-hour and 24-hour formats
- ⚡ **Interactive**: Touch and drag to select time on the clock dial
- 🎯 **Precise Selection**: Scroll wheels for exact minute selection
- 🔧 **Flexible Layout**: Vertical or horizontal combined picker layouts

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ticktock: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Clock Picker

```dart
import 'package:flutter/material.dart';
import 'package:ticktock/ticktock.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('TickTock Example')),
        body: Center(
          child: ClockPicker(
            initialTime: TimeOfDay.now(),
            onTimeChanged: (time) {
              print('Selected time: ${time.format(context)}');
            },
          ),
        ),
      ),
    );
  }
}
```

### Scroll Picker

```dart
TimeScrollPicker(
  initialTime: TimeOfDay(hour: 14, minute: 30),
  onTimeChanged: (time) {
    print('Time changed: $time');
  },
  height: 200.0,
)
```

### Combined Picker (Clock + Scroll)

```dart
CombinedTimePicker(
  initialTime: TimeOfDay.now(),
  onTimeChanged: (time) {
    setState(() {
      selectedTime = time;
    });
  },
  orientation: Axis.vertical, // or Axis.horizontal
  clockSize: 250.0,
  scrollHeight: 150.0,
)
```

### Custom Styling

```dart
ClockPicker(
  initialTime: TimeOfDay.now(),
  style: ClockStyle(
    dialColor: Colors.deepPurple,
    hourHandColor: Colors.purple,
    minuteHandColor: Colors.purpleAccent,
    backgroundColor: Colors.purple.shade50,
    selectedTimeColor: Colors.deepPurple,
    hourTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    use24HourFormat: true,
    showMinuteMarkers: true,
    hourHandWidth: 5.0,
    minuteHandWidth: 3.0,
  ),
  onTimeChanged: (time) {
    // Handle time change
  },
)
```

## Customization Options

### ClockStyle Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `dialColor` | Color | Colors.blue | Color of the clock dial border |
| `hourMarkerColor` | Color | Colors.black87 | Color of hour markers |
| `minuteMarkerColor` | Color | Colors.grey | Color of minute markers |
| `hourHandColor` | Color | Colors.black87 | Color of the hour hand |
| `minuteHandColor` | Color | Colors.black54 | Color of the minute hand |
| `centerDotColor` | Color | Colors.black | Color of the center dot |
| `backgroundColor` | Color | Colors.white | Background color of the clock face |
| `selectedTimeColor` | Color | Colors.blue | Color of selection indicators |
| `hourTextStyle` | TextStyle | Default | Text style for hour numbers |
| `selectedTimeTextStyle` | TextStyle | Default | Text style for selected time |
| `use24HourFormat` | bool | false | Whether to use 24-hour format |
| `showHourNumbers` | bool | true | Whether to show hour numbers |
| `showMinuteMarkers` | bool | true | Whether to show minute markers |
| `hourHandWidth` | double | 4.0 | Width of the hour hand |
| `minuteHandWidth` | double | 2.0 | Width of the minute hand |
| `centerDotSize` | double | 8.0 | Size of the center dot |

### Widget Properties

#### ClockPicker
- `initialTime`: Starting time
- `onTimeChanged`: Callback for time changes
- `style`: ClockStyle configuration
- `size`: Size of the clock widget
- `isInteractive`: Whether the clock responds to touch

#### TimeScrollPicker
- `initialTime`: Starting time
- `onTimeChanged`: Callback for time changes
- `style`: ClockStyle configuration
- `height`: Height of the picker
- `showAmPm`: Whether to show AM/PM selector

#### CombinedTimePicker
- `initialTime`: Starting time
- `onTimeChanged`: Callback for time changes
- `style`: ClockStyle configuration
- `clockSize`: Size of the clock component
- `scrollHeight`: Height of the scroll component
- `orientation`: Layout direction (vertical/horizontal)

## Examples

### Dark Theme Clock

```dart
ClockPicker(
  initialTime: TimeOfDay.now(),
  style: ClockStyle(
    dialColor: Colors.white,
    hourMarkerColor: Colors.white70,
    minuteMarkerColor: Colors.white38,
    hourHandColor: Colors.white,
    minuteHandColor: Colors.white70,
    centerDotColor: Colors.white,
    backgroundColor: Colors.grey.shade900,
    selectedTimeColor: Colors.blue.shade300,
    hourTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

### Minimal Design

```dart
ClockPicker(
  initialTime: TimeOfDay.now(),
  style: ClockStyle(
    dialColor: Colors.transparent,
    hourMarkerColor: Colors.grey.shade300,
    showMinuteMarkers: false,
    backgroundColor: Colors.transparent,
    hourTextStyle: TextStyle(
      fontSize: 14,
      color: Colors.grey.shade600,
    ),
  ),
)
```

### 24-Hour Format with Custom Colors

```dart
CombinedTimePicker(
  initialTime: TimeOfDay.now(),
  style: ClockStyle(
    use24HourFormat: true,
    dialColor: Colors.teal,
    selectedTimeColor: Colors.teal,
    hourHandColor: Colors.teal.shade700,
    minuteHandColor: Colors.teal.shade500,
  ),
  orientation: Axis.horizontal,
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.
