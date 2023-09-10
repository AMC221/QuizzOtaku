import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {


  // collection reference
  final CollectionReference quizCollection = FirebaseFirestore.instance
      .collection('anime');

 Future<void> addQuizz(Map quizData, String quizId )async{
   await quizCollection.doc(quizId).set(quizData).catchError((e){
     print(e.toString());
   });
 }
 Future<void> addQuestion(questionData, String quizId )async{
   await quizCollection.doc(quizId).collection("QNA").add(questionData).catchError((e){
     print(e.toString());
   });
 }
  getQuizzData() async{
    return await quizCollection.snapshots();
  }
  getQuestionData(String quizId) async{
    return await quizCollection.doc(quizId).collection("QNA").get();
  }

  Future<List<QueryDocumentSnapshot>> getQuizzByCategory(String category) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('anime')
        .where('quizCategory', isEqualTo: category)
        .get();

    return querySnapshot.docs;
  }


}

