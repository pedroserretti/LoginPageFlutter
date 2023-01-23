// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _controladorEsqueceuSenha = TextEditingController();

  Future forgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controladorEsqueceuSenha.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Link enviado, verifique a caixa de mensagens em seu e-mail!'),
            );
          });
    } on FirebaseAuthException catch (errorPasswordReset) {
      print(errorPasswordReset);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                errorPasswordReset.message.toString(),
              ),
            );
          });
    }
  }

  @override
  void dispose() {
    _controladorEsqueceuSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //app bar ''recupere a sua senha''
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

      //campo para digitar o e-mail e recuperar a senha.
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
          child: Column(
            children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: TextFormField(
                controller: _controladorEsqueceuSenha,
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

            // design do botão
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell( // verifica se o botão foi apertado
                  onTap: () => {
                    forgotPassword()
                  }, // executa a ação do botão
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
    ),
    );
  }
}
