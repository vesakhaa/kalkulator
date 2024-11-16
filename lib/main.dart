import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator iPhone',
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          )),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  //Class Calculator adalah widgwt stateful karena memiliki nilai yang selalu berubah ketika tombol ditekan
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
      } else if (buttonText == "=") {
        try {
          output = evaluateExpression(
              output.replaceAll("x", "*").replaceAll("÷", "/"));
        } catch (e) {
          output = "Error";
        }
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    //mengonversi expression menjadi hasil perhitungan
    final parsedExpression = Expression.parse(expression);
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});
    return result.toString();
  }

  Widget buildButton(String buttonText, Color color,
      {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 0,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24, bottom: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 80, color: Colors.white),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("C", Colors.grey.shade600),
                  buildButton("+/-", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("÷", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7", Colors.grey.shade600),
                  buildButton("8", Colors.grey.shade600),
                  buildButton("9", Colors.grey.shade600),
                  buildButton("x", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.grey.shade600),
                  buildButton("5", Colors.grey.shade600),
                  buildButton("6", Colors.grey.shade600),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.grey.shade600),
                  buildButton("2", Colors.grey.shade600),
                  buildButton("3", Colors.grey.shade600),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("0", Colors.grey.shade800, widthFactor: 2),
                  buildButton(".", Colors.grey.shade800),
                  buildButton("=", Colors.orange),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
