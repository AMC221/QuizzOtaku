import 'package:flutter/material.dart';

class Question {
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  int correctAnswer;
  String image;

  Question(this.question, this.answer1, this.answer2, this.answer3, this.answer4, this.correctAnswer, this.image);
}