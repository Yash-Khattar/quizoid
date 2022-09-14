class Question {
  String question;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String correctAns;

  Question(
      {required this.correctAns,
      required this.optionA,
      required this.optionB,
      required this.optionC,
      required this.optionD,
      required this.question});
}
