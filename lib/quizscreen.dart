import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizapp/QuizHelper.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/QuizResult.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String apiUrl =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";
  QuizHelper quizHelper;
  int currentQuestion = 0;

  int totalSeconds = 30;
  int elaspsedSeconds = 0;
  int score = 0;

  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
//Here we will call the API
    fetchAllQuiz();
    super.initState();
  }

  /*Method to call API and get the data*/
  fetchAllQuiz() async {
    var response = await http.get(apiUrl);
    var body = response.body;

    var json = jsonDecode(body);

    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer);

      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();

      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elaspsedSeconds = t.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;

    if (correctAnswer == answer) {
      score += 1;
    } else {}
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();
    //check if it is last question
    if (currentQuestion == quizHelper.results.length - 1) {
      //navigate to result screen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResult(score: score),
          ));
    } else {
      setState(() {
        currentQuestion += 1;
      });
        quizHelper.results[currentQuestion].incorrectAnswers
            .add(quizHelper.results[currentQuestion].correctAnswer);

        quizHelper.results[currentQuestion].incorrectAnswers.shuffle();

        initTimer();

    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                /*Creating Header components*/
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/icon-circle.png"),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        "$elaspsedSeconds s",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),

                /*Displaying Questions*/
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Q. ${quizHelper.results[currentQuestion].question}",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                /*Displaying options*/
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: quizHelper
                        .results[currentQuestion].incorrectAnswers
                        .map((options) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            //Calling check answer method
                            checkAnswer(options);
                          },
                          color: Color(0xFF511AAB),
                          colorBrightness: Brightness.dark,
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Text(
                            options,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
