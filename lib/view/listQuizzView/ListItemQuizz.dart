import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String quizId;
  final String quizTitle;
  final String quizImgUrl;
  final Future<int> questionCount;
  final String quizDifficulty;
  final void Function() onTap;

  const ListItem({
    required this.quizId,
    required this.quizTitle,
    required this.quizImgUrl,
    required this.quizDifficulty,
    required this.questionCount,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
        border: Border(
        bottom: BorderSide(
        color: Colors.grey[300]!, // ajuster la couleur de la bordure
        width: 1, // ajuster la taille de la bordure
    ),
    ),
    ),
    child:ListTile(

      title: Text(quizTitle),
      subtitle: FutureBuilder<int>(
        future: questionCount,
        builder: (context, AsyncSnapshot<int> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("...");
          } else {
            return Text("${snapshot.data} questions");
          }
        },
      ),
      textColor: Colors.black,
      // add difficulty text
      trailing: Container(

        decoration: BoxDecoration(

          color: quizDifficulty == 'Facile' ? Colors.green :
          quizDifficulty == 'Difficile' ? Colors.red :
          Colors.yellowAccent,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Text(
          quizDifficulty,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      tileColor: Colors.grey[100],

      leading: CircleAvatar(
        backgroundImage:
            NetworkImage(quizImgUrl),
      ),
      onTap: onTap,
    ),
    );
  }
}




