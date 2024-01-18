import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String _expression = '0';
  String _currentInput = '0';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '0';
        _currentInput = '0';
      } else if (_expression == '0' &&
          ['±', '%', '÷', 'X', '-', '+', '0', '00', '='].contains(buttonText)) {
        _expression = '0';
        _currentInput = '0';
      } else if (_expression == '0' && buttonText != '.') {
        _expression = buttonText;
        _currentInput = _expression;
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == '%') {
        Decimal result = (Decimal.parse(_expression) * Decimal.parse('0.01'));

        _expression = result.toString();
        _currentInput = _expression;
      } else if (buttonText == '±') {
        Decimal result = (Decimal.parse(_expression) * Decimal.fromInt(-1));

        _expression = result.toString();
        _currentInput = _expression;
      } else {
        _expression += buttonText;
        _currentInput = _expression;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Text(
                    _currentInput,
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton('C'),
                            _buildButton('±'),
                            _buildButton('%'),
                            _buildButton('÷'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton('7'),
                            _buildButton('8'),
                            _buildButton('9'),
                            _buildButton('X'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton('4'),
                            _buildButton('5'),
                            _buildButton('6'),
                            _buildButton('-'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton('1'),
                            _buildButton('2'),
                            _buildButton('3'),
                            _buildButton('+'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton('0'),
                            _buildButton('00'),
                            _buildButton('.'),
                            _buildButton('='),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    int color = 0xFF333333;
    int textColor = 0xFFFFFFFF;

    if (['C', '±', '%'].contains(buttonText)) {
      color = 0xFFA5A5A5;
      textColor = 0xFF0D0D0D;
    } else if (['÷', 'X', '-', '+', '='].contains(buttonText)) {
      color = 0xFFFF9F0A;
    }

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(color)),
        shape: MaterialStateProperty.all(const CircleBorder()),
        fixedSize:
            MaterialStateProperty.all(const Size(80.0, 80.0)), // 원하는 크기로 조절
      ),
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: buttonText == '00' ? 25 : 30,
          color: Color(textColor),
        ),
      ),
    );
  }

  void _calculateResult() {
    try {
      Decimal result = eval(_expression);

      _expression = result.toString();
      _currentInput = _expression;
    } catch (e) {
      _expression = 'Error';
      _currentInput = 'Error';
    }
  }

  Decimal eval(String expression) {
    if (expression.contains('+')) {
      List<String> terms = expression.split('+');
      List<Decimal> numbers = terms.map((term) => Decimal.parse(term)).toList();
      return numbers.reduce((Decimal a, Decimal b) => a + b);
    } else if (expression.contains('-')) {
      List<String> terms = expression.split('-');
      List<Decimal> numbers = terms.map((term) => Decimal.parse(term)).toList();
      return numbers.reduce((Decimal a, Decimal b) => a - b);
    } else if (expression.contains('X')) {
      List<String> terms = expression.split('X');
      List<Decimal> numbers = terms.map((term) => Decimal.parse(term)).toList();
      return numbers.reduce((Decimal a, Decimal b) => a * b);
    } else if (expression.contains('÷')) {
      List<String> terms = expression.split('÷');
      List<num> numbers = terms.map((term) => num.parse(term)).toList();
      var divideValue = numbers.reduce((a, b) => a / b);
      return Decimal.parse(divideValue.toString());
    }
    return Decimal.parse(expression);
  }
}
