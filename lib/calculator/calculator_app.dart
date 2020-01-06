import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget{
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculator>{
  
  String equation = "";
  String result = "0";
  String expression = "";
  double equationFontSize = 30.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "AC"){
        equation = "";
        result = "0";
        equationFontSize = 48.0;
        resultFontSize = 30.0;
      }else if(buttonText == "C"){
        equation = equation.substring(0,equation.length -1);
        equationFontSize = 48.0;
        resultFontSize = 30.0;
      }else if(buttonText == "="){
        equationFontSize = 30.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

        }
        catch(e){
          result = "Error";
        }
      }else{
        if(equation == "0"){
          equation =  buttonText;
        }
        equation = equation + buttonText;
      }
    });
  }  
  Widget buildGradientButton(String buttonText, double borderRadius, Color buttoncolor1, Color buttoncolor2, Color textColor){
    return Container(
      width: 50,
      height: 76,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[900], width: 0),
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [buttoncolor1,buttoncolor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () => buttonPressed(buttonText),
          child: Center(child: Text(buttonText,style: TextStyle(color: textColor, fontSize: 35.0, fontFamily: 'OpenSans', fontWeight: FontWeight.w200),)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("電卓アプリケーション"),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(color: Colors.grey[900], width: 2),
            ),
            
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 40, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize, fontFamily: 'OpenSans', fontWeight: FontWeight.w300, color: Colors.blue[700]),),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(color: Colors.grey[900], width: 2),
            ),
            
            alignment: Alignment.topRight,
            padding: EdgeInsets.fromLTRB(10, 30, 40, 74),
            child: Text(result,style: TextStyle(fontSize: resultFontSize, fontFamily: 'OpenSans', fontWeight: FontWeight.w300, color: Colors.white),),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 0.0, 
                ),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildGradientButton("AC",0.0,Colors.grey[900],Colors.grey[900],Colors.blue[700]),
                        buildGradientButton("C",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("%",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("×",0.0,Colors.blue[700],Colors.blue[700],Colors.white),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildGradientButton("7",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("8",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("9",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("÷",0.0,Colors.blue[700],Colors.blue[700],Colors.white),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildGradientButton("4",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("5",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("6",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("+",0.0,Colors.blue[700],Colors.blue[700],Colors.white),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildGradientButton("1",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("2",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("3",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("-",0.0,Colors.blue[700],Colors.blue[700],Colors.white),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildGradientButton("±",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("0",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton(".",0.0,Colors.grey[900],Colors.grey[900],Colors.white),
                        buildGradientButton("=",0.0,Colors.blue[700],Colors.blue[700],Colors.white),
                      ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}