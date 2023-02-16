// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page_pmsf/app/helpers/messages.dart';
import 'package:login_page_pmsf/app/pages/forgot_password/forgot_password_page.dart';
import 'package:login_page_pmsf/app/pages/register/register_page.dart';
import 'package:login_page_pmsf/app/ui/styles/text_styles.dart';
import 'package:page_transition/page_transition.dart';
import '../../ui/styles/colors_app.dart';
import '../../ui/widgets/app_button.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  final VoidCallback showHomePage;
  const LoginPage({Key? key, required this.showRegisterPage, required this.showHomePage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Messages{
  bool _obscureText = true;
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();

  routeTransitionSignUp(showRegisterPage) {
    Navigator.push(
        context,
        PageTransition(
            child: RegisterPage(showLoginPage: () {}),
            type: PageTransitionType.rightToLeft
        )
      );
  }

  forgotPasswordRoute() {
    Navigator.push(
        context,
        PageTransition(
          child: ForgotPasswordPage(),
          type: PageTransitionType.rightToLeft,
        )
    );
  }

  Future singIn() async {

    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controladorEmail.text.trim(),
        password: _controladorSenha.text.trim(),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (
            (context) => HomePage(
              showLoginPage: () {},
            )
          ),
        )
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        showError('Usuário não encontrado');
        log('user not found');
      }
      if (e.code == 'wrong-password') {
        showError('Senha incorreta');
        log('user password is wrong');
      }
      if (e.code == 'unknown')  {
        showError('E-mail ou senha incorretos');
        log('wrong e-mail or password');
      }
    }
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
      // backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                SizedBox(
                  width: 100,
                  height: 140,
                  child: Image.asset('assets/logologin_page.png')
                ),
                SizedBox(height: 10),
            
                // olá novamente!
                Text(
                  'Olá novamente!',
                  style: context.textStyles.textExtraBold.copyWith(fontSize: 40),  
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 5
                    ),
                  child: Center(
                    child: Text(
                      'Seja bem vindo novamente, sentimos a sua falta!',
                      style: context.textStyles.textRegular
                    ),
                  ),
                ),
            
                // campo para digitar o e-mail
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: TextField(
                      controller: _controladorEmail,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: ColorsApp.i.secondary,
                        ),
                        labelText: 'E-mail',
                        labelStyle: context.textStyles.textRegular.copyWith(color: Colors.grey[600]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF757575), width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorsApp.i.primary, width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                // campo para digitar a senha
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                  child: TextField(
                    obscureText: _obscureText,
                    controller: _controladorSenha,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: ColorsApp.i.secondary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }, 
                        icon: Icon(
                          _obscureText? Icons.visibility: 
                          Icons.visibility_off, 
                          color: ColorsApp.i.secondary,
                        ),
                      ),
                      labelText: 'Senha',
                      labelStyle: context.textStyles.textRegular.copyWith(color: Colors.grey[600]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF757575), width: 1.35),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsApp.i.primary, 
                          width: 1.35
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                          style: context.textStyles.textBold.copyWith(color: ColorsApp.i.secondary)
                        )
                      ),
                    ],
                  ),
                ),
            
                // botão entrar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AppButton(
                    onPressed: singIn,
                    label: 'Entrar',
                    width: 370,
                    height: 50,
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
                      onTap: () => {
                        routeTransitionSignUp(widget.showRegisterPage)
                      },
                      child: Text(
                        ' Crie uma conta!',
                        style: TextStyle(
                          color: ColorsApp.i.secondary,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                  ],
                )
              ]
            ),
        ),
      ),
    );
  }
}
