import 'package:flutter/material.dart';
import '../utils/time_utils.dart';
import '../widgets/bottom_nav_bar.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final _controller = TextEditingController();
  String _result = '';

  void _convert() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _result = 'Please enter number of years';
      });
      return;
    }
    int? years = int.tryParse(input);
    if (years == null || years < 0) {
      setState(() {
        _result = 'Please enter a valid positive integer';
      });
      return;
    }
    final converted = TimeUtils.yearsToTime(years);
    setState(() {
      _result =
          '${converted['years']} years = ${converted['hours']} hours = ${converted['minutes']} minutes = ${converted['seconds']} seconds';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Conversion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter years',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 24),
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
