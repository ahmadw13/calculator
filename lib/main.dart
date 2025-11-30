import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // --- Logic Variables ---
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  // --- Logic Function ---
  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    // Remove .0 if the result is a whole number (e.g. 5.0 -> 5)
    if (_output.endsWith(".0")) {
       _output = _output.substring(0, _output.length - 2);
    }

    setState(() {
      output = _output;
    });
  }

  // --- UI Helper Widget ---
  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10.0), // Spacing between buttons
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), // Makes the button round
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(20.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We define our colors here for consistency
    const Color greyBtn = Color(0xFF333333); 
    const Color amberBtn = Colors.amber;
    const Color lightGreyBtn = Color(0xFFA5A5A5);

    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Column(
        children: <Widget>[
          // Display Area
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(
                  vertical: 24.0, horizontal: 12.0),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 80.0, // Much larger font
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // Button Area
          Column(children: [
            Row(children: [
              buildButton("C", lightGreyBtn, Colors.black),
              buildButton("+/-", lightGreyBtn, Colors.black),
              buildButton("%", lightGreyBtn, Colors.black),
              buildButton("/", amberBtn, Colors.white),
            ]),
            Row(children: [
              buildButton("7", greyBtn, Colors.white),
              buildButton("8", greyBtn, Colors.white),
              buildButton("9", greyBtn, Colors.white),
              buildButton("x", amberBtn, Colors.white),
            ]),
            Row(children: [
              buildButton("4", greyBtn, Colors.white),
              buildButton("5", greyBtn, Colors.white),
              buildButton("6", greyBtn, Colors.white),
              buildButton("-", amberBtn, Colors.white),
            ]),
            Row(children: [
              buildButton("1", greyBtn, Colors.white),
              buildButton("2", greyBtn, Colors.white),
              buildButton("3", greyBtn, Colors.white),
              buildButton("+", amberBtn, Colors.white),
            ]),
            Row(children: [
              // To make the 0 button wider (stadium shape), we need a slight tweak. 
              // For now, let's keep it simple with a circle logic 
              // but we will place two items in the first slot just to fill space or keep it standard.
              // Let's stick to standard grid for consistency.
              buildButton("0", greyBtn, Colors.white),
              buildButton("00", greyBtn, Colors.white),
              buildButton(".", greyBtn, Colors.white),
              buildButton("=", amberBtn, Colors.white),
            ]),
            const SizedBox(height: 10), // Bottom padding
          ])
        ],
      ),
    );
  }
}