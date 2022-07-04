import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';

import 'presenters/login_page.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Services().open();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text("Bem Vindo"),          
        ),
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}

