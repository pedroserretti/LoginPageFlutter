// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_page_pmsf/components/home_modal_add.dart.';
import 'package:login_page_pmsf/pages/login_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool acceptTerms = false;
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();
  final _controladorConfirmarSenha = TextEditingController();
  final _controladorNome = TextEditingController();

  routeTransition(showLoginPage) {
    Navigator.push(
      context,
      PageTransition(
        child: LoginPage(showRegisterPage: () {}),
        type: PageTransitionType.leftToRight,
      ),
    );
  }

  Future termsAndConditions() async {
    await showBarModalBottomSheet(
        context: context, builder: (context) => HomeModalAdd());
    if (!acceptTerms) {}
  }

  Future signUp() async {
    if (acceptTerms != true) {
      return RegisterPage(showLoginPage: () {});
    }

    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controladorEmail.text.trim(),
          password: _controladorSenha.text.trim());
    }
  }

  bool passwordConfirmed() {
    if (_controladorSenha.text.trim() ==
        _controladorConfirmarSenha.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    _controladorConfirmarSenha.dispose();
    _controladorNome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 100,
              height: 200,
            ),

            SizedBox(height: 10),

            // olá novamente!
            Text(
              'Registre-se',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),

            SizedBox(height: 30),

            // campo para digitar o nome
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                child: TextField(
                  controller: _controladorNome,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.35),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Nome Completo',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // campo para digitar o e-mail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _controladorEmail,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),

            SizedBox(height: 30),

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
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),

            SizedBox(height: 30),

            // campo para confirmar a senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                obscureText: true,
                controller: _controladorConfirmarSenha,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Confirme sua senha',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),

            SizedBox(height: 10),

            // termos e condições.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: acceptTerms,
                  activeColor: Colors.greenAccent,
                  onChanged: (checked) {
                    setState(() {
                      acceptTerms = checked!;
                    });
                  },
                ),
                Text(
                  'Eu li e concordo com os',
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: termsAndConditions,
                  child: Text(' Termos e Condições.',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),

            SizedBox(height: 30),

            // botão entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                // verifica se o botão foi apertado
                onTap: signUp, // executa a ação do botão
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 80,
                          offset: Offset(3, 5),
                        )
                      ]),
                  child: const Center(
                    child: Text(
                      'Registrar',
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
                  'Já tem uma conta?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    routeTransition(widget.showLoginPage),
                  },
                  child: Text(' Faça seu login!',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
