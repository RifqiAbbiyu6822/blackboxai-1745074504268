import 'package:flutter/material.dart';
import '../utils/number_utils.dart';
import '../widgets/bottom_nav_bar.dart';

class NumberTypeScreen extends StatefulWidget {
  @override
  _NumberTypeScreenState createState() => _NumberTypeScreenState();
}

class _NumberTypeScreenState extends State<NumberTypeScreen> {
  final _controller = TextEditingController();
  String _result = '';

  void _checkNumber() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() {
        _result = 'Please enter a number';
      });
      return;
    }

    bool isInt = int.tryParse(input) != null;
    bool isDec = double.tryParse(input) != null && input.contains('.');
    int? intValue = int.tryParse(input);

    List<String> types = [];

    if (isInt && intValue != null) {
      if (isPrime(intValue)) types.add('Prime');
      if (isPositive(intValue)) types.add('Positive Integer');
      if (isNegative(intValue)) types.add('Negative Integer');
      if (isWholeNumber(intValue)) types.add('Whole Number');
    }
    if (isDec) types.add('Decimal');

    setState(() {
      if (types.isEmpty) {
        _result = 'Unknown or invalid number type';
      } else {
        _result = 'Number types: ' + types.join(', ');
      }
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
        title: Text('Number Type Checker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                labelText: 'Enter a number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkNumber,
              child: Text('Check Number Type'),
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
