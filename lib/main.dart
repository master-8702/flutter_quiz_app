import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'questions_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart'; // this package is used for the final alert dialog box

//here we create an object of questionsList class , that we are gonna use down later
QuestionsList questionsList = QuestionsList();

//the starting point of our app
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: const Text(
          "Quiz App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: const HomePage(),
    ),
  ));
}

// the homepage class
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int questionNumber = 0;
  int correctAnswerCount = 0;

  //this is the alert style that we are gonna use it the user finishes the quiz
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: const TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: const Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: const BorderSide(
        color: Colors.yellow,
      ),
    ),
    titleStyle: const TextStyle(
      color: Colors.lightBlue,
    ),
    alertAlignment: Alignment.topCenter,
  );

  //this method is for checking the user submitted answer and trigger re-rendering of the app

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questionsList.getAnswer();
    int currentQuestionNumber = questionsList.getCurrentQuestionNumber() + 1;
    int totalQuestionsNumber = questionsList.getTotalquestionsNumber();

    setState(() {
      //here if the user gets the correct answer we will increment the correct answer counter
      // we are going to use it on the final dialog box to show how many correct answers the user got
      // *****
      //after that  we will check if current question number and total question number are equal
      // if they are equal it means the user finished the quiz .. so will display the alert.
      if (userAnswer == correctAnswer) {
        correctAnswerCount++;
      }
      if (currentQuestionNumber == totalQuestionsNumber) {
        // here we will create the alert (dialog box) that we will show at the end of the quiz
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.info,
          title: "Quiz Finished!",
          desc: "You got $correctAnswerCount out of $totalQuestionsNumber.",
          buttons: [
            DialogButton(
              child: const Text(
                "Retry",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  //here if the user pressed retry on the dialog box, we will reset the current question number
                  // and resetting current question number in the class(plus we are inside setState) will trigger
                  // the re-rendering of our screen and display questions again starting from question number 1
                  questionsList.resetCurrentQuestionNumber();
                  correctAnswerCount = 0;
                });
              },
              color: Colors.yellow[800],
              radius: BorderRadius.circular(12.0),
            ),
            DialogButton(
              child: Text(
                "Exit",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                //but here if the user clicks exit on the dialog box ... we will just exit the app
                // since using exit(0) makes it look like the app crashed
                //we used another method to close the app and gave it 0.7 second delay to just not close immediately

                // exit(0);
                Future.delayed(const Duration(milliseconds: 700), () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              },
              color: Colors.yellow[800],
              radius: BorderRadius.circular(12.0),
            ),
          ],
        ).show();
      }

      // unless the current question number is equal to the total number of questions we will fetch the next
      // question as follow
      questionsList.nextQuestion();
    });
  }

  //here is the full app's UI ... question counter, question displaying, true/false buttons ...
  @override
  Widget build(BuildContext context) {
    int currentQuestionNumber = questionsList.getCurrentQuestionNumber() + 1;
    int totalQuestionsNumber = questionsList.getTotalquestionsNumber();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                currentQuestionNumber.toString() +
                    "/" +
                    totalQuestionsNumber.toString(),
                style: TextStyle(
                  fontSize: 22,
                ),
              )
            ],
          ),
        ),
        Spacer(), //we added it just to add space from top
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questionsList
                        .getQuestion(), // here we will fetch the questions to display to the user
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //here on the setState method we will call checkAnswer method to check the submitted answer and
                        //to fetch the next question
                        checkAnswer(true);
                      });
                    },
                    child: const Text(
                      'True',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: Colors.yellow[800]),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //here on the setState method we will call checkAnswer method to check the submitted answer and
                        //to fetch the next question
                        checkAnswer(false);
                      });
                    },
                    child: const Text('False', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: Colors.yellow[800]),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
