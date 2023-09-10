import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzflutter/models/Question.dart';
import 'package:quizzflutter/services/DatabaseService.dart';
import 'package:random_string/random_string.dart';
import 'package:quizzflutter/view/quizzAddView/QuestionAdd.dart';

class QuizzCreator extends StatefulWidget {
  const QuizzCreator({Key? key}) : super(key: key);

  @override
  _QuizzCreatorState createState() => _QuizzCreatorState();
}

class _QuizzCreatorState extends State<QuizzCreator> {
  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  late String quizImgUrl, quizTitle, quizDesc, quizCategory,quizLevel;
  final categories = [
    "4 images 1 anime",
    "4 images 1 perso",
    "Image floue",
    "Eye quizz",
    "Hair quizz",
    "Place quizz",
  ];

  bool isLoading = false;
  late String quizId;


  createQuiz(){

    quizId = randomAlphaNumeric(16);
    if(_formKey.currentState!.validate()){

      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizImgUrl" : quizImgUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDesc,
        "quizCategory" : quizCategory,
        "quizLevel" : quizLevel,
      };

      databaseService.addQuizz(quizData, quizId).then((value){
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  AddQuestion(quizId)
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: const Text("Create Quiz",
          style: TextStyle(
              color: Colors.black54
          ),),
        elevation: 0.0,
        backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Image Url" : null,
                decoration: const InputDecoration(
                    hintText: "Quiz Image Url (Optional)"
                ),
                onChanged: (val){
                  quizImgUrl = val;
                },
              ),
              const SizedBox(height: 5,),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: const InputDecoration(
                    hintText: "Quiz Title"
                ),
                onChanged: (val){
                  quizTitle = val;
                },
              ),
              const SizedBox(height: 5,),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: const InputDecoration(
                    hintText: "Quiz Description"
                ),
                onChanged: (val){
                  quizDesc = val;
                },

              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: "Select a category",
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),

                items: [
                  for (String category in categories)
                    DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    quizCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 5,),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  hintText: "Select a difficulty",
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Facile",
                    child: Text("Facile"),
                  ),
                  DropdownMenuItem(
                    value: "Moyen",
                    child: Text("Moyen"),
                  ),
                  DropdownMenuItem(
                    value: "Difficile",
                    child: Text("Difficile"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    quizLevel = value.toString();
                  });
                },
              ),

              const Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Create Quiz",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],)
          ,),
      ),
    );
  }
}