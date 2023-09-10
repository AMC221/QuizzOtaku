import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzflutter/services/DatabaseService.dart';
import '../gameQuizz/quizzPlay.dart';
import 'package:get/get.dart';
import 'ListItemQuizz.dart';

class myQuizzList extends StatefulWidget {
  final String category = "eyequizz";
  final String title;
  final Color color;

  const myQuizzList({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  _myQuizzListState createState() => _myQuizzListState();
}

class _myQuizzListState extends State<myQuizzList> {
  late Future<List<QueryDocumentSnapshot>> quizList;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    quizList = databaseService.getQuizzByCategory(widget.title);
  }

  Future<int> getQuestionCountForQuizzes(String quizId) async {
    QuerySnapshot snapshot =
    await databaseService.getQuestionData(quizId) as QuerySnapshot;
    return snapshot.docs.length;
  }

  void _showConfirmationDialog(String quizId, String quizTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: Text("Voulez-vous commencer le quiz $quizTitle?"),
          actions: <Widget>[
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirmer"),
              onPressed: () {
                //naviger avec Getx
                Get.off(() => QuizPlay(quizId));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: widget.color,
      ),
      body: FutureBuilder(
        future: quizList,
        builder:
            (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Aucun quiz trouvé"),
            );
          } else {
            return
              ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    quizId: snapshot.data![index].id,
                    quizTitle: snapshot.data![index].get("quizTitle"),
                    quizImgUrl: snapshot.data![index].get("quizImgUrl"),
                    quizDifficulty: snapshot.data![index].get("quizLevel"),
                    questionCount: getQuestionCountForQuizzes(
                        snapshot.data![index].id),
                    onTap: () {
                      _showConfirmationDialog(
                          snapshot.data![index].id,
                          snapshot.data![index].get("quizTitle"));
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}


// creer itemListQuizz

