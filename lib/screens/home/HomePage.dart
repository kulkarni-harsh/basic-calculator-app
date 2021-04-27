import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String equation = "0";

  String result = "0";

  String expression = "";

  double equationFontSize = 38;

  double resultFontSize = 48;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "⌫") {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              child: Text(
            equation,
            style: TextStyle(fontSize: equationFontSize),
          )),
          Container(
              child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          )),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      CalcButton("C", 1, Colors.red),
                      CalcButton("⌫", 1, Colors.blue),
                      CalcButton("÷", 1, Colors.blue)
                    ]),
                    TableRow(children: [
                      CalcButton("7", 1, Colors.blue),
                      CalcButton("8", 1, Colors.blue),
                      CalcButton("9", 1, Colors.blue)
                    ]),
                    TableRow(children: [
                      CalcButton("4", 1, Colors.blue),
                      CalcButton("5", 1, Colors.blue),
                      CalcButton("6", 1, Colors.blue)
                    ]),
                    TableRow(children: [
                      CalcButton("1", 1, Colors.blue),
                      CalcButton("2", 1, Colors.blue),
                      CalcButton("3", 1, Colors.blue)
                    ]),
                    TableRow(children: [
                      CalcButton(".", 1, Colors.blue),
                      CalcButton("0", 1, Colors.blue),
                      CalcButton("00", 1, Colors.blue)
                    ]),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(child: CalcButton("×", 1, Colors.blue)),
                  Container(child: CalcButton("−", 1, Colors.blue)),
                  Container(child: CalcButton("+", 1, Colors.blue)),
                  Container(child: CalcButton("=", 2, Colors.red)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget CalcButton(operation, buttonheight, colorno) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: colorno.withOpacity(0.8),
          border: Border.all(color: Colors.amber)),
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      child: TextButton(
          onPressed: () => buttonPressed(operation),
          child: Text(
            operation,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          )),
    );
  }
}
