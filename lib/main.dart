import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';

  void onNumberPress(String number) {
    setState(() {
      if (display == '0') {
        display = number;
      } else {
        display += number;
      }
    });
  }

  void onOperatorPress(String operator) {
    setState(() {
      display += operator;
    });
  }

  void onClear() {
    setState(() {
      display = '0';
    });
  }

  void onCalculate() {
    try {
      final result = _calculateExpression(display);
      setState(() {
        display = result.toString();
      });
    } catch (e) {
      setState(() {
        display = 'Error';
      });
    }
  }

  // Oddiy ifodalarni hisoblash uchun yordamchi funksiya
  double _calculateExpression(String expression) {
    // Bu yerda, biz faqat oddiy ifodalarni qo'llab-quvvatlaymiz
    // Misol: '3+2', '4*5' va h.k.
    // Kengroq hisoblash logikasini amalga oshirish uchun qo'shimcha kutubxona kerak bo'ladi
    final RegExp regExp = RegExp(r'(\d+)([\+\-\*/])(\d+)');
    final match = regExp.firstMatch(expression);

    if (match != null) {
      final num1 = double.parse(match.group(1)!);
      final operator = match.group(2);
      final num2 = double.parse(match.group(3)!);

      switch (operator) {
        case '+':
          return num1 + num2;
        case '-':
          return num1 - num2;
        case '*':
          return num1 * num2;
        case '/':
          if (num2 != 0) {
            return num1 / num2;
          } else {
            throw FormatException("Division by zero");
          }
        default:
          throw FormatException("Invalid operator");
      }
    }

    throw FormatException("Invalid expression");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                display,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  final button = buttons[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: button['color'],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      final value = button['value'];
                      if (value == 'C') {
                        onClear();
                      } else if (value == '=') {
                        onCalculate();
                      } else if ('+-*/%'.contains(value)) {
                        onOperatorPress(value);
                      } else {
                        onNumberPress(value);
                      }
                    },
                    child: Text(
                      button['value'],
                      style: TextStyle(
                        fontSize: 24,
                        color: button['value'] == 'C'
                            ? Colors.white
                            : Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> buttons = [
  // {'value': '%', 'color': Colors.blue},
  // {'value': '+/-', 'color': Colors.blue},
  {'value': '7', 'color': Colors.blue[700]},
  {'value': '8', 'color': Colors.blue[700]},
  {'value': '9', 'color': Colors.blue[700]},
  {'value': '/', 'color': Colors.blue[700]},

  {'value': '4', 'color': Colors.blue[700]},
  {'value': '5', 'color': Colors.blue[700]},
  {'value': '6', 'color': Colors.blue[700]},
  {'value': '*', 'color': Colors.blue[700]},

  {'value': '1', 'color': Colors.blue[700]},
  {'value': '2', 'color': Colors.blue[700]},
  {'value': '3', 'color': Colors.blue[700]},
  {'value': '-', 'color': Colors.blue[700]},
  {'value': '0', 'color': Colors.blue[700]},
  {'value': '.', 'color': Colors.blue[700]},
  {'value': '=', 'color': Colors.blue[700]},
  {'value': '+', 'color': Colors.blue[700]},
  // {'value': '<', 'color': Colors.blue},
  {'value': 'C', 'color': Colors.blue[700]},
];
