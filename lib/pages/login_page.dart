// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page_pmsf/pages/forgot_password_page.dart';
import 'package:login_page_pmsf/pages/register_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  final VoidCallback showHomePage;
  const LoginPage({Key? key, required this.showRegisterPage, required this.showHomePage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();

  routeTransitionSingUp(showRegisterPage) {
    Navigator.push(
        context,
        PageTransition(
            child: RegisterPage(showLoginPage: () {}),
            type: PageTransitionType.rightToLeft));
  }

  forgotPasswordRoute() {
    Navigator.push(
        context,
        PageTransition(
          child: ForgotPasswordPage(),
          type: PageTransitionType.rightToLeft,
        ));
  }

  Future singIn() async {

    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
    });
  
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _controladorEmail.text.trim(),
      password: _controladorSenha.text.trim(),
      );
  
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    if (e.code == 'user-not-found') {
      showEmailError();
    }
    else if (e.code == 'wrong-password') {
      showPasswordError();
    }
    else if (e.code == 'unknown')  {
      showUnknownError();
    }
  }
}

  void showEmailError(){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.greenAccent,
          title: Center(
            child: Text(
              'E-mail incorreto',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        );
    });
  }

   void showPasswordError(){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.greenAccent,
          title: Center(
            child: Text(
              'Senha incorreta',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        );
    });
  }

   void showUnknownError(){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.greenAccent,
          title: Center(
            child: Text(
              'Campo obrigatório',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        );
    });
  }


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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 100,
              height: 140,
              child: Image.asset('assets/logologin_page.png'),
            ),

            SizedBox(height: 10),

            // olá novamente!
            Text(
              'Olá novamente!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
              child: Center(
                child: Text(
                  'Seja bem vindo novamente, sentimos a sua falta!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            // campo para digitar o e-mail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextFormField(
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

            // campo para digitar a senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
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

            // esqueceu a sua senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: forgotPasswordRoute,
                      child: Text(
                        'Esqueceu a sua senha?',
                        style: TextStyle(color: Colors.grey[600]),
                      )),
                ],
              ),
            ),

            // botão entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
              child: InkWell( // verifica se o botão foi apertado
                onTap: singIn, // executa a ação do botão
                child: Ink(
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
                  onTap: () => {routeTransitionSingUp(widget.showRegisterPage)},
                  child: Text(' Crie uma conta!',
                      style: TextStyle(
                        color: Colors.green,
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
