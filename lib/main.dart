import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '';
  double firstOperand = 0.0;
  double secondOperand = 0.0;
  String operator = '';
  String result = '';

  // Function to handle number button tap
  void onButtonPressed(String value) {
    setState(() {
      displayText += value;
    });
  }

  // Function to handle operator button tap
  void onOperatorPressed(String op) {
    setState(() {
      if (displayText.isNotEmpty) {
        firstOperand = double.parse(displayText);
        operator = op;
        displayText = '';
      }
    });
  }

  // Function to calculate the result based on operator
  void onEqualsPressed() {
    setState(() {
      if (displayText.isNotEmpty) {
        secondOperand = double.parse(displayText);
        switch (operator) {
          case '+':
            result = (firstOperand + secondOperand).toString();
            break;
          case '-':
            result = (firstOperand - secondOperand).toString();
            break;
          case '*':
            result = (firstOperand * secondOperand).toString();
            break;
          case '/':
            if (secondOperand != 0) {
              result = (firstOperand / secondOperand).toString();
            } else {
              result = 'Error';
            }
            break;
          default:
            result = 'Error';
        }
        displayText = result;
      }
    });
  }

  // Function to clear the display
  void onClearPressed() {
    setState(() {
      displayText = '';
      firstOperand = 0.0;
      secondOperand = 0.0;
      operator = '';
      result = '';
    });
  }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display area
            Text(
              displayText,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('0'),
                buildButton('C', action: onClearPressed),
                buildButton('=', action: onEqualsPressed),
                buildButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a button
  Widget buildButton(String label, {void Function()? action}) {
    return ElevatedButton(
      onPressed: action ??
          () {
            if (int.tryParse(label) != null) {
              onButtonPressed(label);
            } else {
              onOperatorPressed(label);
            }
          },
      child: Text(
        label,
        style: const TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(80, 80),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}
