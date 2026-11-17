import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '0';
  String _operand = '';
  double _firstNumber = 0;
  bool _newNumber = true;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _operand = '';
        _firstNumber = 0;
        _newNumber = true;
      } else if (value == '=') {
        if (_operand.isNotEmpty) {
          double secondNumber = double.parse(_display);
          double result = 0;
          
          switch (_operand) {
            case '+':
              result = _firstNumber + secondNumber;
              break;
            case '-':
              result = _firstNumber - secondNumber;
              break;
            case '×':
              result = _firstNumber * secondNumber;
              break;
            case '÷':
              result = _firstNumber / secondNumber;
              break;
          }
          
          _display = result.toString();
          _operand = '';
          _firstNumber = result;
          _newNumber = true;
        }
      } else if (['+', '-', '×', '÷'].contains(value)) {
        if (_operand.isEmpty) {
          _firstNumber = double.parse(_display);
          _operand = value;
          _newNumber = true;
        } else {
          _onButtonPressed('=');
          _operand = value;
          _newNumber = true;
        }
      } else if (value == '.') {
        if (_newNumber) {
          _display = '0.';
          _newNumber = false;
        } else if (!_display.contains('.')) {
          _display += '.';
        }
      } else {
        if (_newNumber) {
          _display = value;
          _newNumber = false;
        } else {
          _display += value;
        }
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(24),
            shape: const RoundedRectangleBorder(),
            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildButton('C', color: Colors.red),
                _buildButton('⌫', color: Colors.orange),
                _buildButton('÷', color: Colors.blue),
                _buildButton('×', color: Colors.blue),
              ],
            ),
            Row(
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('-', color: Colors.blue),
              ],
            ),
            Row(
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('+', color: Colors.blue),
              ],
            ),
            Row(
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('=', color: Colors.green),
              ],
            ),
            Row(
              children: [
                _buildButton('0'),
                _buildButton('.'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}