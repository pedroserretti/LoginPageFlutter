// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page_pmsf/authentication/main_page.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override 
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey <FormState> _formKey = GlobalKey();
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();

    Future singIn() async {

    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid){
    }
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _controladorEmail.text.trim(), 
      password: _controladorSenha.text.trim(),
    );
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
                'Olá novamente!',
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
                  'Seja bem vindo novamente, sentimos a sua falta!',
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
                  key: _formKey,
                child: TextFormField(
                  controller: _controladorEmail,
                  validator: Validatorless.multiple([
                    Validatorless.email('Digite o seu e-mail'),
                    Validatorless.required('E-mail inválido')
                  ]),
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
                child: TextFormField(
                  obscureText: true,
                  controller: _controladorSenha,
                  validator: 
                    Validatorless.required('Senha inválida'),
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
                onTap: singIn, // executa a ação do botão
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
                onTap: widget.showRegisterPage,
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