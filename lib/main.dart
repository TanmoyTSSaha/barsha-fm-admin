import 'package:barsha_fm_admin_panel/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyB7UBioUFYsb3RCL4e9rM2bJzcdVK2pM6k',
    appId: '1:716336886605:web:feb0cfae028215e4adbd04',
    messagingSenderId: '716336886605',
    projectId: 'barsha-fm',
    storageBucket: "barsha-fm.appspot.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barsha FM Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
