import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_base_one/Create.dart';
import 'package:my_base_one/Read.dart';
import 'package:my_base_one/firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    // home:Read()
    home:Creation()
  ));
}
