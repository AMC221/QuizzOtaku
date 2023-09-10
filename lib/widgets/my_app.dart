import 'package:flutter/material.dart';
import 'home.dart';
import 'package:quizzflutter/view/homepage.dart';
import 'package:quizzflutter/view/quizzAddView/quizzCreator.dart';
import 'package:quizzflutter/view/listQuizzView/myQuizzList.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 /* @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Quizz anime'),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16),
          button: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}