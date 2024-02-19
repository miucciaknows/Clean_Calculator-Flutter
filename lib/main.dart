import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';

  void _onPressed(String text) {
    if (text == '=') {
      _calculate();
    } else if (text == 'Erase') {
      _clear();
    } else {
      setState(() {
        _output += text;
      });
    }
  }

  void _calculate() {
    try {
      String expression = _output;
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _output = eval.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'Error';
      });
    }
  }

  void _clear() {
    setState(() {
      _output = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _output.isEmpty ? '0' : _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 167, 164, 163), 
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                '7',
                '8',
                '9',
                '/',
                '4',
                '5',
                '6',
                '*',
                '1',
                '2',
                '3',
                '-',
                'Erase',
                '0',
                '=',
                '+',
              ].map((text) => _buildButton(text)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return GestureDetector(
      onTap: () => _onPressed(text),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24.0,
            color: Color(0xFFF7C5B0)
          ),
        ),
      ),
    );
  }
}
