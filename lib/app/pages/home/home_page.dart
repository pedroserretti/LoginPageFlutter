// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_pmsf/app/pages/login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required Null Function() showLoginPage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(  
      MaterialPageRoute(
        builder: (
          (context) => LoginPage(
            showHomePage: () {}, 
            showRegisterPage: () {}
          )
        ),
      )
    );
  } 
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              'Logado como: ' + user.email!,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          
            const SizedBox(height: 20),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: signOut,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Center(
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}