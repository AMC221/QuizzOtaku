import 'package:flutter/material.dart';


class ListeDesQuizz extends StatelessWidget {
  final String title;
  final Color color;

  const ListeDesQuizz({Key? key, required this.title,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: Center(
        child: Text('Les quiz de la catégorie $title seront affichés ici'),
      ),
    );
  }
}
