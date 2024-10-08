import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userInput) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    
    setState(() {
    if (quizBrain.reachedLastQuestion()) {
      Alert(
      context: context,
      title: "Finished!",
      desc: "Reached the last question.",
    ).show();

      quizBrain.resetQuestionNumber();
      scoreKeeper = [];
      
      return;
    }

    if (userInput == correctAnswer) {
      scoreKeeper.add(
        Icon(Icons.check, color: Colors.green),
      );
    } else {
      scoreKeeper.add(
        Icon(Icons.close, color: Colors.red),
      );
    }

      quizBrain.nextQuestion();
    });
  }

  Text displayQuestion () {
    return Text(
     quizBrain.getQuestionText(),
      textAlign: TextAlign.center,
      style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: displayQuestion(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.green)),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(backgroundColor:WidgetStatePropertyAll<Color>(Colors.red)),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

