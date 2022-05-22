// this class will be the blue print for the questions
//it's created for project-organizational(cleanness) purpose

class Question {
  String questionText = "";
  bool questionAnswer = true;
  Question(String question, bool answer) {
    questionText = question;
    questionAnswer = answer;
  }
}
