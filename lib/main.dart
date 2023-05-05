import 'dart:ui';

import 'package:flutter/material.dart';
import 'first_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  AppBar _buildAppBar(){
    return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(119, 241, 219, 1),
          Color.fromRGBO(33, 70, 113, 0.42)
        ])
      ),
    ),
    title: const Center(child: Text('Users', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Urbanist'),)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Container(        
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(205, 205, 205, 1),
          Color.fromRGBO(115, 134, 156, 0.42)
        ])
      ),
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: _buildAppBar(),
          body: const FirstPage(),
        ),
      ),
    );
  }
}




