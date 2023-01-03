// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();

  Future signUp() async {}
  
  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 140,
                child: Image.asset('assets/logologin_page.png'),
              ),
            
            SizedBox(height: 10),

            // olá novamente!
              Text(
                'Olá!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: Text(
                  'Crie a sua conta!',
                    style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),

              SizedBox(height: 20),

              // campo para digitar o e-mail
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                child: TextField(
                  controller: _controladorEmail,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent, width: 1.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // campo para digitar a senha
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  controller: _controladorSenha,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent, width: 1.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                      hintText: 'Senha',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),

              SizedBox(height: 5),

              // esqueceu a sua senha
            Padding( 
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(
                  'Esqueceu a sua senha?',
                  style: TextStyle(
                    color: Colors.grey[600]
                  ),
                )
              ]),
            ),
      
            SizedBox(height: 30),

            // botão entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector( // verifica se o botão foi apertado
                onTap: signUp, // executa a ação do botão
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: const Center(
                  child: Text(
                    'Entrar',
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
  

            const SizedBox(height: 20),

            // botão registrar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                'Não é um membro?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(
                  ' Crie uma conta!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ]
          ,)
        ]),
      ),
    ),
  );
}}