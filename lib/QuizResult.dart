import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/quizscreen.dart';

class QuizResult extends StatelessWidget {

  int score=0;

  QuizResult({this.score});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Center(
                child: Image(
                  image: AssetImage("assets/icon-circle.png"),
                  width: 300,
                  height: 300,
                ),
              ),
              Text("Result",
                  style: TextStyle(color: Color(0xFFA20CBE), fontSize: 35)),
              Text("${score}/10",
                  style: TextStyle(color: Color(0xFFFFBA00), fontSize: 60)),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "RESTART",
                    style: TextStyle(fontSize: 32),
                  ),
                  color: Color(0xFFFFBA00),
                  textColor: Colors.white,
                  onPressed: () {
                    //Navigating to next page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>QuizScreen(),
                        )
                    );

                  },
                ),
              ),

              /*Quit the game*/

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Quit",
                    style: TextStyle(fontSize: 32),
                  ),
                  color: Color(0xFFA20CBE),
                  textColor: Colors.white,
                  onPressed: () {
                    //Navigating to next page
                    Navigator.pop(context);

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RestartQuiz(){

  }
}
