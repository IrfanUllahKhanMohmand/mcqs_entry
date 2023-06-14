import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mcqs_entry/common/hive_adopters/available_adopter.dart';

import 'common/utills/app_constants.dart';

class Global {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AvailableAdopter());
    }
    await Hive.openBox(appBox);
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDO3edKovL1X-ozT1kUlzLCkOhaA60TBBU",
            authDomain: "quizappdb-d6c67.firebaseapp.com",
            databaseURL: "https://quizappdb-d6c67-default-rtdb.firebaseio.com",
            projectId: "quizappdb-d6c67",
            storageBucket: "quizappdb-d6c67.appspot.com",
            messagingSenderId: "788913363184",
            appId: "1:788913363184:web:ecd0743ffa1849867a0a35"));
  }
}
