import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBKxoBLvFhdtClXApdrmrjCO6leAg-XzB0",
    authDomain: "flutter-firebase-login-8633e.firebaseapp.com",
    projectId: "flutter-firebase-login-8633e",
    storageBucket: "flutter-firebase-login-8633e.appspot.com",
    messagingSenderId: "171289908784",
    appId: "1:171289908784:web:5671b985661aaf42907ff5",
    measurementId: "G-9NQ92MT20G",
  ));
  runApp(const App());
}
