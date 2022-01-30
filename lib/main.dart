import 'package:flutter/material.dart';
import 'package:eval_ex/expression.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    return runApp(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  String txt = '';
  String result = '';

  Text btnText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 25),
    );
  }

  Expanded button({Color? color, String? number}) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: const CircleBorder(),
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 0.0),
        ),
        onPressed: () {
          setState(() {
            txt += '$number';
          });
        },
        child: btnText('$number'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  result,
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  txt,
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[600],
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 0.0),
                  ),
                  onPressed: () {
                    setState(() {
                      txt = '';
                    });
                  },
                  child: btnText('AC'),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[600],
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 0.0),
                  ),
                  onPressed: () {
                    setState(() {
                      if (txt[0] == '-') {
                        txt = txt.substring(1);
                      } else {
                        String minus = "-";
                        txt = minus + txt;
                      }
                    });
                  },
                  child: btnText('+/-'),
                ),
              ),
              button(color: Colors.grey[600], number: '%'),
              button(color: Colors.orange, number: '/'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(color: Colors.grey[850], number: '7'),
              button(color: Colors.grey[850], number: '8'),
              button(color: Colors.grey[850], number: '9'),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 0.0),
                  ),
                  onPressed: () {
                    setState(() {
                      txt += '*';
                    });
                  },
                  child: btnText('x'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(color: Colors.grey[850], number: '4'),
              button(color: Colors.grey[850], number: '5'),
              button(color: Colors.grey[850], number: '6'),
              button(color: Colors.orange, number: '-'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(color: Colors.grey[850], number: '1'),
              button(color: Colors.grey[850], number: '2'),
              button(color: Colors.grey[850], number: '3'),
              button(color: Colors.orange, number: '+'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 0),
                      backgroundColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        txt += '0';
                      });
                    },
                    child: const Text(
                      '0',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              button(color: Colors.grey[850], number: '.'),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 0.0),
                  ),
                  onPressed: () {
                    setState(() {
                      try {
                        Expression exp = Expression(txt);
                        String a = exp.eval().toString();
                        Decimal.parse(a);
                        result = a;
                        txt = '';
                      } on Exception catch (exception) {
                        // only executed if error is of type Exception
                      } catch (error) {
                        txt =
                            'Error'; // executed for errors of all types other than Exception
                      }
                    });
                    // catch (Expression.ExpressionException e){
                    // input.setText("");
                    // addToResult("Error");
                    // }
                    // catch (EmptyStackException e) {
                    //
                    // }
                    // catch (ArithmeticException e){
                    // input.setText("");
                    // addToResult("Error");
                    // }
                  },
                  child: btnText('='),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
