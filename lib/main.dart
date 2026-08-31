import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_app/Database/SQLiteDBHelper.dart';
import 'package:quiz_app/SplashScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

late SQLiteDBHelper sqliteDBHelper;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  sqliteDBHelper = SQLiteDBHelper();
  await sqliteDBHelper.getDatabase();

  runApp(
    const MaterialApp(
      title: "Quiz App",
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}