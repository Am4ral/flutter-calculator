import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
       ), // ThemeData
       home: const MyHomePage(title: 'Flutter Demo Home Page'),
     ); // MaterialApp
   }
}
  
class MyHomePage extends StatefulWidget {
   const MyHomePage({Key? key, required this.title}) : super(key: key);
   final String title;
   @override
   State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  var expression = '';
  var result = '';
  var ans = '';

  final List<String> btns = [
    "C","DEL","%","/",
    "7","8","9","x",
    "4","5","6","-",
    "1","2","3","+",
    "0",",","ANS","=",
  ];


  @override
  Widget build(BuildContext context) {
   return Scaffold(
       backgroundColor: Colors.black,
       body: Column(
           children: <Widget>[
                Container(
                   child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(height: 50,),
                        Container(
                            padding: EdgeInsets.all(25),
                            alignment: Alignment.centerRight,
                            child: Text(expression, style: TextStyle(fontSize: 35, color: Colors.white)),),
                        Container(
                            padding: EdgeInsets.all(25),
                            alignment: Alignment.centerRight,
                            child: Text(result, style: TextStyle(fontSize: 35, color: Colors.white)),),
                     ],
                   ), 
                ),
            Expanded(
                flex: 2,
                child: Container(
                    child: GridView.builder(
                      itemCount: btns.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index){
                        //Clear Button
                        if(index == 0){
                          return Buttons(
                            buttonTapped: (){
                            setState(() {
                              expression = '';                              
                              result = '';
                            });
                          },
                          buttonText: btns[index],
                          color: Colors.blue[50],
                          textColor: Colors.blue,
                          );
                        }
                        //Del Button
                        else if(index == 1){
                          return Buttons(
                            buttonTapped: (){
                            setState(() {
                              expression = expression.substring(0,expression.length-1);                              
                            });
                          },
                          buttonText: btns[index],
                          color: Colors.blue[50],
                          textColor: Colors.blue,
                          );
                        }
                        //Equal Button
                        else if(index == btns.length-1){
                          return Buttons(
                            buttonTapped: (){
                            setState(() {
                             solve_expression(); 
                            });
                          },
                          buttonText: btns[index],
                          color: Colors.blue,
                          textColor: Colors.white,
                          );
                        }
                        //Answer Button
                        else if(index == btns.length-2){
                          return Buttons(
                            buttonTapped: (){
                            setState(() {
                              expression += ans;                              
                            });
                          },
                          buttonText: btns[index],
                          color: Colors.blue,
                          textColor: Colors.white,
                          );
                        }
                        return Buttons(
                          buttonTapped: (){
                            setState(() {
                              expression += btns[index];                              
                            });
                          },
                          buttonText: btns[index],
                          color: isOperator(btns[index]) ? Colors.blue : Colors.blue[50],
                          textColor: isOperator(btns[index]) ? Colors.white : Colors.blue, 
                        );
                      }),
                ),
            ),
           ]
        )
    );
  }

  bool isOperator(String x){
    if(x == '%' ||x == '/' ||x == 'x' ||x == '-' ||x == '+' ||x == '='){
      return true;
    } 
    return false;
  }
  
  void solve_expression(){
    String finalExpression = expression;
    finalExpression = finalExpression.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalExpression);    
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    
    result = eval.toString();
    ans = result;    

  }
}
