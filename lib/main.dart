import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;

  //Button Widget
  Widget calcbutton(String txt, Color color) {
    return Container(
      child: MaterialButton(
        onPressed: () {
          calculation(txt);
        },
        shape: CircleBorder(),
        color: color,
        padding: EdgeInsets.all(20),
        child: Text(
          '$txt',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget bigcalcbutton(String txt, Color color) {
    return Container(
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(78, 20, 75, 20),
        onPressed: () {
          calculation(txt);
        },
        shape: StadiumBorder(),
        color: color,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '$txt',
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                bigcalcbutton('AC', Colors.grey),
                // calcbutton('+/-',Colors.grey,Colors.black),
                calcbutton('^', Colors.orange.shade400),
                calcbutton('/', Colors.orange.shade400),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.grey),
                calcbutton('8', Colors.grey),
                calcbutton('9', Colors.grey),
                calcbutton('*', Colors.orange.shade400),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.grey),
                calcbutton('5', Colors.grey),
                calcbutton('6', Colors.grey),
                calcbutton('-', Colors.orange.shade400),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.grey),
                calcbutton('2', Colors.grey),
                calcbutton('3', Colors.grey),
                calcbutton('+', Colors.orange.shade400),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                bigcalcbutton('0', Colors.grey),
                calcbutton('.', Colors.grey),
                calcbutton('=', Colors.orange.shade600),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  String text = "0";
  String result = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      result = '';
    } else if (btnText == '=') {
      if (text[text.length - 1] == "-" ||
          text[text.length - 1] == "+" ||
          text[text.length - 1] == "/" ||
          text[text.length - 1] == "*" ||
          text[text.length - 1] == "^") {
      } else if (text.endsWith("/0")) {
        result = "don't divide by zero";
      } else {
        if (text.endsWith(".")) {
          text = text.substring(0, text.length - 1);
        }
        var x = Parser().parse(text);
        var ex = x.evaluate(EvaluationType.REAL, ContextModel());
        result = ex.toString();
        if (result.endsWith(".0")) {
          result = result.replaceAll(".0", "");
        }
      }
    } else {
      result = text + btnText;
    }
    setState(() {
      text = result;
    });
  }
}
