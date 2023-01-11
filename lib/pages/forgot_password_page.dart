// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _controladorEsqueceuSenha = TextEditingController();

  @override
  void dispose() {
    _controladorEsqueceuSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Recupere a sua senha',
          style: TextStyle(
            color: Color(0xFF252525),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF464545)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: TextFormField(
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
                  hintText: 'Digite um e-mail válido',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  // verifica se o botão foi apertado
                  onTap: () => {}, // executa a ação do botão
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
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
            ]),
          ]),
        ),
      ),
    );
  }
}
