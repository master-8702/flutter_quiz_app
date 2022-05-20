import 'package:flutter/material.dart';
import 'questions_list.dart';

QuestionsList questionsList = QuestionsList();

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: const Text(
          "Quizz App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: const HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int questionNumber = 0;
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
        Spacer(),
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questionsList.getQuestion(),
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
                        questionsList.nextQuestion();
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
                        questionsList.nextQuestion();
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
