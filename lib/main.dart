import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

Box? box;
Future<void> main() async {
  // await Hive.initFlutter();
  // Box box = await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var UserQuestion = ' ';

var UserAnswer = ' ';

class _HomePageState extends State<HomePage> {
  final MyTextStyle = const TextStyle(fontSize: 30, color: Colors.blue);
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(UserQuestion,
                          style: const TextStyle(fontSize: 30))),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        UserAnswer,
                        style: const TextStyle(fontSize: 35),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            UserQuestion = '';
                            UserAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple[50],
                        textColor: Colors.black,
                      );
                    }
                    if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            UserQuestion = UserQuestion.substring(
                                0, UserQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple[50],
                        textColor: Colors.black,
                      );
                    }
                    if (index == 2) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            UserQuestion += buttons[index];
                            UserAnswer = UserQuestion.substring(
                                0, UserQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue,
                        textColor: Colors.deepPurple[50],
                      );
                    }
                    if (index == 3) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            UserQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue,
                        textColor: Colors.deepPurple[50],
                      );
                    }
                    if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            // UserQuestion += buttons[index];
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue,
                        textColor: Colors.deepPurple[50],
                      );
                    }

                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          UserQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.blue
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.deepPurple[50]
                          : Colors.blue,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == 'x' || x == '/' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = UserQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    UserAnswer = eval.toString();
  }
}
