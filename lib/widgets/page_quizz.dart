import 'package:flutter/material.dart';
import 'package:quizzflutter/widgets/home.dart';
import 'package:quizzflutter/widgets/my_app.dart';
import 'custom_text.dart';
import 'package:quizzflutter/models/Question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzflutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizzflutter/services/DatabaseService.dart';


class PageQuizz extends StatefulWidget {
  const PageQuizz({Key?key, required this.title});
  final String title;


  @override
  State<PageQuizz> createState() => _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz>{
  DatabaseService databaseService = DatabaseService();
  late Question question;
  List<Question> ListQuestion = [
    Question("Trouver l'anime ?", 'one punch man', 'fairy tail', 'Naruto', 'MHA', 1, 'assets/photo1.jpg'),
    Question("Trouver l'anime ?", 'food wars', 'angel death', 'your lie in april', 'MHA', 3, 'assets/photo2.jpg'),
    Question("Trouver l'anime ?", 'jjk', 'Kiseyju', 'snk', 'DBZ', 2, 'assets/photo3.jpg'),
    Question("Trouver l'anime ?", 'Dr stone ', 'Steins gate', 'jjba', 'overlord', 2, 'assets/photo4.jpg'),
    Question("Trouver l'anime ?", 'konosuba', 'Log Horizon', 'Overlord', 'SAO',4, 'assets/photo5.jpg'),
    Question("Trouver le personnage ?", 'karma', 'arthur', 'kurapika', 'ang', 3, 'assets/photo6.jpg'),
    Question("Trouver le personnage ?", 'eren', 'reiner', 'deku', 'byakuya', 1, 'assets/photo7.jpg'),
    Question("Trouver le personnage ?", 'mikassa', 'goku', 'luffy', 'kaguya', 4, 'assets/photo8.jpg'),
    Question("Trouver le personnage ?", 'saitama', 'goku', 'ciel', 'kaguya', 3, 'assets/photo9.jpg'),
    Question("Trouver le personnage ?", 'kazuma', 'nagisa', 'ciel', 'ichigo', 2, 'assets/photo10.jpg'),
  ];

  int index = 0;
  int score = 0;
  Color color = Colors.cyan;

  
  @override
  void initState() {
    super.initState();
    question = ListQuestion[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomText('Question numéro ${index + 1}', factor: 1.5, color: Colors.black,),
            CustomText('Score : $score / ${ListQuestion.length}', factor: 1.5, color: Colors.black,),
            Card(
              elevation: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset(question.image,
                    fit: BoxFit.cover
                ),
              ),
            ),
            CustomText(question.question, factor: 1.5, color: Colors.black,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(80, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                      disabledForegroundColor: Colors.red.withOpacity(0.38),
                      disabledBackgroundColor: Colors.red.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      verifyAnswer(1);
                    },
                    child: CustomText(question.answer1, factor: 1.5, color: Colors.white,),
                  ),
                ),
                Expanded(

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                      disabledForegroundColor: Colors.red.withOpacity(0.38),
                      disabledBackgroundColor: Colors.red.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      verifyAnswer(2);
                    },
                    child: CustomText(question.answer2, factor: 1.5, color: Colors.white,),
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(80, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                      disabledForegroundColor: Colors.red.withOpacity(0.38),
                      disabledBackgroundColor: Colors.red.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      verifyAnswer(3);
                    },
                    child: CustomText(question.answer3, factor: 1.5, color: Colors.white,),
                  ),
                ),
                Expanded(

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                      disabledForegroundColor: Colors.red.withOpacity(0.38),
                      disabledBackgroundColor: Colors.red.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      verifyAnswer(4);
                    },
                    child: CustomText(question.answer4, factor: 1.5, color: Colors.white,),
                  ),
                ),
              ],
            ),
      ]
    ,),
    ),
    );
  }

  // alerte pour dire  que la reponse est bonne
  Future<Null> alerteBonneReponse() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bonne réponse'),
            content: Text('Bien jouer'),
            alignment: Alignment.center,
            icon: const Icon(Icons.check_circle_outline, color: Colors.green, size: 50,),
            actions: <Widget>[
              ElevatedButton(



                style: ElevatedButton.styleFrom(
                  fixedSize: Size(120, 40),

                  alignment: Alignment.center,
                  foregroundColor: Colors.white,
                  backgroundColor: color,
                  disabledForegroundColor: Colors.red.withOpacity(0.38),
                  disabledBackgroundColor: Colors.red.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                // changement de couleur du bouton onHover
                onHover: (isHovering) {
                  setState(() {
                    if (isHovering) {
                      color = Colors.red;
                    } else {
                      color = Colors.cyan;
                    }
                  });
                },
                onPressed: () {
                  index++;
                  if (index == ListQuestion.length) {
                    alerteFinQuizz();
                  }
                  setState(() {
                    question = ListQuestion[index];
                  });

                  Navigator.of(context).pop();

                },
                child: CustomText('Suivant', factor: 1.5, color: Colors.white,),
              ),
            ],
          );
        });
  }

  // alerte pour dire  que la reponse est mauvaise
  Future<Null> alerteMauvaiseReponse() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mauvaise réponse'),
            content: Text(' mauvaise reponse'),
            alignment: Alignment.center,
            icon: Icon(Icons.error_outline, color: Colors.red, size: 50,),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(120, 40),
                  alignment: Alignment.center,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.cyan,
                  disabledForegroundColor: Colors.red.withOpacity(0.38),
                  disabledBackgroundColor: Colors.red.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  index++;
                  if (index == ListQuestion.length) {
                    alerteFinQuizz();
                  }
                  setState(() {
                    question = ListQuestion[index];
                  });

                  Navigator.pop(context);

                },
                child: CustomText('Suivant', factor: 1.5, color: Colors.white,),
              ),
            ],
          );
        });
  }

  // alerte fin de quizz
  Future<Null> alerteFinQuizz() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fin du quizz'),
            content: Text('Vous avez fini le quizz Score : $score / ${ListQuestion.length}'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(80, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.cyan,
                  disabledForegroundColor: Colors.red.withOpacity(0.38),
                  disabledBackgroundColor: Colors.red.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'home',)));
                },
                child: CustomText('OK', factor: 1.5, color: Colors.white,),
              ),
            ],
          );
        });
  }



  void verifyAnswer(int answer){
    if (answer == question.correctAnswer){
      score++;
      alerteBonneReponse();
    }else{
      alerteMauvaiseReponse();
    }
    if (index < ListQuestion.length - 1){


    }
    else{

    }
  }

}