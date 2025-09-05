import 'package:flutter/material.dart';
import 'package:ticktock/ticktock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TickTock Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TickTockExamplePage(),
    );
  }
}

class TickTockExamplePage extends StatefulWidget {
  @override
  _TickTockExamplePageState createState() => _TickTockExamplePageState();
}

class _TickTockExamplePageState extends State<TickTockExamplePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TimeOfDay basicTime = TimeOfDay.now();
  TimeOfDay customTime = TimeOfDay(hour: 14, minute: 30);
  TimeOfDay darkTime = TimeOfDay(hour: 9, minute: 15);
  TimeOfDay minimalTime = TimeOfDay(hour: 16, minute: 45);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TickTock Examples'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Basic'),
            Tab(text: 'Custom'),
            Tab(text: 'Dark'),
            Tab(text: 'Minimal'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBasicExample(),
          _buildCustomExample(),
          _buildDarkExample(),
          _buildMinimalExample(),
        ],
      ),
    );
  }

  Widget _buildBasicExample() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic TickTock Example',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Simple time picker with default styling',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          SizedBox(height: 20),
          _buildTimeDisplay('Selected Time', basicTime),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                padding: EdgeInsets.all(20),
                child: TickTock(
                  initialTime: basicTime,
                  height: 250,
                  onTimeChanged: (time) {
                    setState(() {
                      basicTime = time;
                    });
                  },
                  style: TicktockStyle(
                    selectedTimeColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    infiniteScroll: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomExample() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Styled TickTock',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '24-hour format with action buttons',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          SizedBox(height: 20),
          _buildTimeDisplay('Selected Time', customTime),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal.shade200, width: 2),
                ),
                padding: EdgeInsets.all(20),
                child: TickTock(
                  initialTime: customTime,
                  height: 280,
                  onTimeChanged: (time) {
                    setState(() {
                      customTime = time;
                    });
                  },
                  onTimeSelected: (time) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Time confirmed: ${time.format(context)}'),
                        backgroundColor: Colors.teal,
                      ),
                    );
                  },
                  onTimeCancelled: (time) {
                    setState(() {
                      customTime = TimeOfDay.now();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Time selection cancelled'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  style: TicktockStyle(
                    use24HourFormat: true,
                    infiniteScroll: true,
                    showDoneButton: true,
                    showCancelButton: true,
                    selectedTimeColor: Colors.teal,
                    backgroundColor: Colors.transparent,
                    hourLabelText: 'Hour (24h)',
                    minuteLabelText: 'Minute',
                    doneButtonText: 'Confirm',
                    cancelButtonText: 'Reset',
                    hourLabelTextStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade700,
                    ),
                    minuteLabelTextStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade700,
                    ),
                    selectedTimeTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkExample() {
    return Container(
      color: Colors.grey.shade900,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dark Theme TickTock',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Dark theme with cyan accents',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
            ),
            SizedBox(height: 20),
            _buildTimeDisplay('Selected Time', darkTime, isDark: true),
            SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.cyan.shade700),
                  ),
                  padding: EdgeInsets.all(20),
                  child: TickTock(
                    initialTime: darkTime,
                    height: 280,
                    onTimeChanged: (time) {
                      setState(() {
                        darkTime = time;
                      });
                    },
                    style: TicktockStyle(
                      backgroundColor: Colors.transparent,
                      selectedTimeColor: Colors.cyan,
                      dialColor: Colors.cyan,
                      hourTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                      selectedTimeTextStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                      hourLabelTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.cyan.shade300,
                      ),
                      minuteLabelTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.cyan.shade300,
                      ),
                      periodLabelTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.cyan.shade300,
                      ),
                      hourLabelText: 'Hr',
                      minuteLabelText: 'Min',
                      periodLabelText: 'Period',
                      infiniteScroll: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalExample() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Minimal Design TickTock',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Clean and simple design with subtle styling',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          SizedBox(height: 20),
          _buildTimeDisplay('Selected Time', minimalTime),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: TickTock(
                  initialTime: minimalTime,
                  height: 220,
                  onTimeChanged: (time) {
                    setState(() {
                      minimalTime = time;
                    });
                  },
                  style: TicktockStyle(
                    backgroundColor: Colors.transparent,
                    selectedTimeColor: Colors.black87,
                    dialColor: Colors.grey.shade300,
                    hourTextStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    selectedTimeTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    hourLabelTextStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.5,
                    ),
                    minuteLabelTextStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.5,
                    ),
                    periodLabelTextStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.5,
                    ),
                    hourLabelText: 'HOUR',
                    minuteLabelText: 'MINUTE',
                    periodLabelText: 'PERIOD',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay(String label, TimeOfDay time, {bool isDark = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.cyan.shade700 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            time.format(context),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.cyan : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

// Additional dialog example
class TimePickerDialog extends StatelessWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const TimePickerDialog({
    Key? key,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Time'),
      content: SizedBox(
        height: 250,
        width: 300,
        child: TickTock(
          initialTime: initialTime,
          onTimeSelected: (time) {
            onTimeSelected(time);
            Navigator.of(context).pop();
          },
          onTimeCancelled: (_) {
            Navigator.of(context).pop();
          },
          style: TicktockStyle(
            showDoneButton: true,
            showCancelButton: true,
            selectedTimeColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            infiniteScroll: true,
          ),
        ),
      ),
    );
  }

  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
  }) {
    return showDialog<TimeOfDay>(
      context: context,
      builder: (context) => TimePickerDialog(
        initialTime: initialTime,
        onTimeSelected: (time) => Navigator.of(context).pop(time),
      ),
    );
  }
}