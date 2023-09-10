import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzflutter/models/QuestionModel.dart';
import 'package:quizzflutter/services/DatabaseService.dart';
import 'package:quizzflutter/view/gameQuizz/resultPage.dart';

class QuizPlay extends StatefulWidget {
  final String quizId;
  QuizPlay(this.quizId);

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> {
  int _correct = 0;
  int _incorrect = 0;
  int _notAttempted = 0;
  int total = 0;
  late Timer timer;
  int start = 20;

  List<QuestionModel>? questionList;
  //recuperer les questions
  DatabaseService databaseService = DatabaseService();
  late QuerySnapshot questionSnaphot;

  int currentQuestionIndex = 0;



  @override
  void initState() {
    super.initState();
    // load the questions and shuffle them
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.docs.length;
      _correct = 0;
      _incorrect = 0;
      questionList = [];
      // loop through each question document and create a QuestionModel object for it
      for (var questionDocument in questionSnaphot.docs) {
        QuestionModel questionModel = getQuestionModelFromDatasnapshot(questionDocument);
        questionList!.add(questionModel);
      }
      // shuffle the list of questions
      questionList!.shuffle();
      // set the state to re-render the UI with the loaded questions
      setState(() {});
    });
    startTimer();

  }


  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();

    questionModel.question = questionSnapshot["question"];

    // shuffling the options
    List<String> options = [
      questionSnapshot["option1"],
      questionSnapshot["option2"],
      questionSnapshot["option3"],
      questionSnapshot["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot["option1"];


    return questionModel;
  }

  @override
  Widget build(BuildContext context) {
    if (questionList == null) {
      // show loading indicator while questions are being loaded
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // show the current question and options as buttons
      final currentQuestion = questionList![currentQuestionIndex];
      var correctAnswer = currentQuestion.correctOption;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz"),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget> [
            const SizedBox(height: 16.0),
            Text(
              'Score: $_correct / ${questionList!.length}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // display timer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer,color: Colors.cyan, size: 40.0, ),

                const SizedBox(width: 20.0),
                Text(
                  '$start',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Card(

              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.6,
                child: SizedBox(
                  // display images
                  child: Image.network(
                    currentQuestion.question,
                    fit: BoxFit.contain,),


                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        verifyAnswer(currentQuestion.option1, correctAnswer);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        backgroundColor: Colors.cyan,
                      ),
                      child: Text(currentQuestion.option1,
                        style: const TextStyle(color: Colors.white, ),textScaleFactor: 1, textAlign: TextAlign.center,)
                    ),
                    ElevatedButton(
                      onPressed: () {
                        verifyAnswer(currentQuestion.option2, correctAnswer);
                      },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          backgroundColor: Colors.cyan,
                        ),
                      child: Text(currentQuestion.option2,
                          style: const TextStyle(color: Colors.white, ),textScaleFactor: 1, textAlign: TextAlign.center,)
                    ),

                    ElevatedButton(
                      onPressed: () {
                        verifyAnswer(currentQuestion.option3, correctAnswer);
                      },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),

                          ),
                          backgroundColor: Colors.cyan,
                        ),
                      child: Text(currentQuestion.option3, style: const TextStyle(color: Colors.white, ),textScaleFactor: 1, textAlign: TextAlign.center,)
                    ),
                    ElevatedButton(
                      onPressed: () {
                        verifyAnswer(currentQuestion.option4, correctAnswer);
                      },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          backgroundColor: Colors.cyan,
                        ),
                      child: Text(currentQuestion.option4, style: const TextStyle(color: Colors.white, ),textScaleFactor: 1, textAlign: TextAlign.center,)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  verifyAnswer(String option, String correctAnswer) {
    if(currentQuestionIndex == questionList!.length - 1) {
      if (option == correctAnswer) {
        showNotification();
        setState(() {
          _correct++;
          start= 20;
        });
      } else {
        showNotificationIncorrect();
        setState(() {
          _incorrect++;
          start = 20;
        });
      }
      showResults();
    } else {
      // verify answer
      // increase the correct or incorrect count
      // move to next question
      // setState(() {}
    if (option == correctAnswer) {
      showNotification();
      setState(() {
        _correct++;
        start = 20;
      });
    } else {
      showNotificationIncorrect();
      setState(() {
        _incorrect++;
        start = 20;
      });
    }
    setState(() {
      _notAttempted++;
      currentQuestionIndex++;
    });



    }
  }

  void showResults() {
    //navigate to result page with getx
    Get.off(() =>ResultPage(
      correctAnswers: _correct,
      totalQuestions: questionList!.length,
    ));
  }
  void nextQuestion() {

    if(currentQuestionIndex == questionList!.length - 1) {
      showResults();
    } else {
      setState(() {
        _notAttempted++;
        currentQuestionIndex++;
      });
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (timer) {
        if (start == 0) {
          nextQuestion();
          setState(() {
            start= 10;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }
  // faire une notification correct ou incorrect
void showNotification() {
  Get.snackbar(
    "Correct",
    "Bien joué",
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
    maxWidth: MediaQuery.of(context).size.width * 0.50,
    icon: const Icon(Icons.check),
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 20,

  );
}

void showNotificationIncorrect() {
  Get.snackbar(
    "Incorrect !",
    "Dommage",
    backgroundColor: Colors.red,

    colorText: Colors.white,
    icon: const Icon(Icons.error),
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
    maxWidth: MediaQuery.of(context).size.width * 0.50,

    snackStyle: SnackStyle.FLOATING,
    borderRadius: 20,


  );
}

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

}
