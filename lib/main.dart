import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/quizscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "productsans",
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
              Text("Quiz",
                  style: TextStyle(color: Color(0xFFA20CBE), fontSize: 90)),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "PLAY",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
