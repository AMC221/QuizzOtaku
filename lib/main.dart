import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzflutter/firebase_options.dart';
import 'package:quizzflutter/widgets/my_app.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),));
}




