import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calc());

class Calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calc',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scalc(),
    );
  }
}

class Scalc extends StatefulWidget {
  @override
  _ScalcState createState() => _ScalcState();
}

class _ScalcState extends State<Scalc> {
  String eq = '0';
  String res = '0';
  String expr = '';
  double eqfontSize = 38;
  double resfontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        eq = '0';
        res = '0';
        eqfontSize = 38;
        resfontSize = 48;
      } else if (buttonText == '⌦') {
        eqfontSize = 48;
        resfontSize = 38;
        eq = eq.substring(0, eq.length - 1);
        if (eq == '') {
          eq = '0';
        }
      } else if (buttonText == "=") {
        eqfontSize = 38;
        resfontSize = 48;
        expr = eq;
        expr = expr.replaceAll('×', '*');
        expr = expr.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expr);

          ContextModel cm = ContextModel();
          res = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          res = "Error";
        }
      } else {
        eqfontSize = 38;
        resfontSize = 48;
        if (eq == '0') {
          eq = "";
        }
        eq = eq + buttonText;
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      // ignore: deprecated_member_use
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.indigo, Colors.blue[400]]),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              eq,
              style: TextStyle(fontSize: eqfontSize),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.indigo, Colors.blue[400]]),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              res,
              style: TextStyle(fontSize: resfontSize),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.indigo, Colors.blue[400]]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.indigo, Colors.blue[400]]),
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.red[700]),
                        buildButton("⌦", 1, Colors.red),
                        buildButton("÷", 1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("^", 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.green),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
