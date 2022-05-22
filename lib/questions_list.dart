import 'package:quiz_app/question.dart';

//this class is used to hold the question's list
// we separately put this class for cleanness purpose

class QuestionsList {
  //since the class itself will handle the current question number and resetting it
  // the following variables are needed
  int _currentQuestionNumber = 0;
  int totalQuestionNumber = 0;

  final List<Question> _myQuestions = [
    Question(
        "The computer will carry out the instructions that follow the symbol //.",
        false),
    Question("A program must have a main function.", true),
    Question(
        "The following is an example of a declaration statement:\n cout << “Enter a number: ”;",
        false),
    Question("An identifier must start with a letter or an underscore.", true),
    Question("It is best to use very short identifiers.", false),
    Question(
        "In the statement below: “Hello!” is called a string literal.\n cout << “Hello!”",
        true),
    Question(
        "There is no limit on the size of the numbers that can be stored in the int data type.",
        false),
    Question("76.45e-2 is a valid value for a float data type.", true),
    Question(
        "There are only two possible values for the bool data type.", true),
    Question("All data types take up the same amount of storage.", false),
    Question(
        "It is good program style to put spaces between words and symbols.",
        true),
    Question("A C++ statement cannot extend over more than one line.", false),
    Question("In C++ addition is always evaluated before subtraction.", false),
    Question("The value of 3/7 is 0.", true),
    Question(">> is used for output.", false),
  ];

  //this function will fetch the next question for whomever asks and increment the current question number counter by one

  void nextQuestion() {
    if (_currentQuestionNumber < (totalQuestionNumber - 1)) {
      _currentQuestionNumber++;
    }
  }

  //this is just a getter method for the class(questions_list) questions
  String getQuestion() {
    return _myQuestions[_currentQuestionNumber].questionText;
  }

  //this is just a getter method for the class(questions_list) answers

  bool getAnswer() {
    return _myQuestions[_currentQuestionNumber].questionAnswer;
  }

  //another getter method for total questions number
  int getTotalquestionsNumber() {
    totalQuestionNumber = _myQuestions.length;
    return totalQuestionNumber;
  }

  //another getter method for current questions number

  int getCurrentQuestionNumber() {
    return _currentQuestionNumber;
  }

  //a method for resetting the current question number counter

  void resetCurrentQuestionNumber() {
    _currentQuestionNumber = 0;
  }
}
