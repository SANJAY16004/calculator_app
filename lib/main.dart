import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  Widget calcButton(String btnTxt, Color? btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btnTxt);
      },
      child: Text(
        '$btnTxt',
        style: TextStyle(
          fontSize: 35,
          color: txtColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: btnColor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  void calculation(String btnTxt) {
    if (btnTxt == 'AC') {
      setState(() {
        text = '0';
        numOne = 0;
        numTwo = 0;
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';
      });
    } else if (opr == '=' && btnTxt == '=') {
      setState(() {
        if (preOpr == '+') {
          finalResult = add();
        } else if (preOpr == '-') {
          finalResult = sub();
        } else if (preOpr == 'x') {
          finalResult = mul();
        } else if (preOpr == '/') {
          finalResult = div();
        }
      });
    } else if (btnTxt == '+' ||
        btnTxt == '-' ||
        btnTxt == 'x' ||
        btnTxt == '/' ||
        btnTxt == '=') {
      setState(() {
        if (numOne == 0) {
          numOne = double.parse(result);
        } else {
          numTwo = double.parse(result);
        }

        if (opr == '+') {
          finalResult = add();
        } else if (opr == '-') {
          finalResult = sub();
        } else if (opr == 'x') {
          finalResult = mul();
        } else if (opr == '/') {
          finalResult = div();
        }
        preOpr = opr;
        opr = btnTxt;
        result = '';
      });
    } else if (btnTxt == '%') {
      setState(() {
        result = (numOne / 100).toString();
        finalResult = doesContainDecimal(result);
      });
    } else if (btnTxt == '.') {
      setState(() {
        if (!result.contains('.')) {
          result += '.';
        }
        finalResult = result;
      });
    } else if (btnTxt == '+/-') {
      setState(() {
        result = result.startsWith('-') ? result.substring(1) : '-' + result;
        finalResult = result;
      });
    } else {
      setState(() {
        result += btnTxt;
        finalResult = result;
      });
    }
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (int.parse(splitDecimal[1]) > 0) {
        return result;
      }
      return splitDecimal[0];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('7', Colors.grey[850], Colors.white),
                calcButton('8', Colors.grey[850], Colors.white),
                calcButton('9', Colors.grey[850], Colors.white),
                calcButton('x', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('4', Colors.grey[850], Colors.white),
                calcButton('5', Colors.grey[850], Colors.white),
                calcButton('6', Colors.grey[850], Colors.white),
                calcButton('-', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('1', Colors.grey[850], Colors.white),
                calcButton('2', Colors.grey[850], Colors.white),
                calcButton('3', Colors.grey[850], Colors.white),
                calcButton('+', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.grey[850],
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                ),
                calcButton('.', Colors.grey[850], Colors.white),
                calcButton('=', Colors.amber[700], Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
