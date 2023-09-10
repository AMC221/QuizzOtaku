
class QuestionModel{

  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String correctOption;


  static fromMap(data) {
    return QuestionModel()
      ..question = data['question']
      ..option1 = data['option1']
      ..option2 = data['option2']
      ..option3 = data['option3']
      ..option4 = data['option4']
      ..correctOption = data['option1'];

  }

  //QuestionModel(this.question, this.option1, this.option2, this.option3, this.option4, this.correctOption, this.answered);

}