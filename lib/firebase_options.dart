// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBdehZkU7dOGrw1DBF8bu49bXs7RrM2R80',
    appId: '1:165332961775:web:149147763efc6c604b8e1a',
    messagingSenderId: '165332961775',
    projectId: 'quizzotaku',
    authDomain: 'quizzotaku.firebaseapp.com',
    storageBucket: 'quizzotaku.appspot.com',
    measurementId: 'G-JMNRXS2T3S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl91T-SEeGetnmy23d4JBWgsy657PjIqU',
    appId: '1:165332961775:android:a7c355db7be0629c4b8e1a',
    messagingSenderId: '165332961775',
    projectId: 'quizzotaku',
    storageBucket: 'quizzotaku.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBu8yRmmjnPMtBf-uye5XjpH85yJt-fIYo',
    appId: '1:165332961775:ios:ff4ae117a214ca134b8e1a',
    messagingSenderId: '165332961775',
    projectId: 'quizzotaku',
    storageBucket: 'quizzotaku.appspot.com',
    iosClientId: '165332961775-isfkom5mveu2m7j32app7rk0dq64b6cv.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizzflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBu8yRmmjnPMtBf-uye5XjpH85yJt-fIYo',
    appId: '1:165332961775:ios:ff4ae117a214ca134b8e1a',
    messagingSenderId: '165332961775',
    projectId: 'quizzotaku',
    storageBucket: 'quizzotaku.appspot.com',
    iosClientId: '165332961775-isfkom5mveu2m7j32app7rk0dq64b6cv.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizzflutter',
  );
}
