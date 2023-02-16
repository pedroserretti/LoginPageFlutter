// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_pmsf/app/helpers/messages.dart';
import 'package:login_page_pmsf/app/helpers/size_extensions.dart';
import 'package:login_page_pmsf/app/ui/styles/text_styles.dart';



import '../../ui/styles/colors_app.dart';
import '../../ui/widgets/app_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with Messages{
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _controladorEsqueceuSenha = TextEditingController();

  Future<void> forgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _controladorEsqueceuSenha.text.trim());
      showSuccess('Link de e-mail enviado com sucesso, verifique sua caixa de e-mail!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') {
        log('unknown');
        showError('É necessário digitar um e-mail para recuperar sua senha');
      }
      if (e.code == 'user-not-found') {
        log('user not found');
        showError('Usuário não encontrado');
      }
      if (e.code == 'invalid-email') {
        log('user not found');
        showError('O e-mail está inválido ou mal formatado');
      }
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
      appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            title: Text(
              'Recupere a sua senha',
              style: context.textStyles.textBold.copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: ColorsApp.i.primary,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45)
              )
            ),
          ),

      //campo para digitar o e-mail e recuperar a senha.
      body: Center(
        child: SizedBox(
          height: context.percentHeight(0.5),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: TextFormField(
                      controller: _controladorEsqueceuSenha,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: context.textStyles.textRegular
                            .copyWith(color: Colors.grey[600]),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF757575), width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.greenAccent, width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  // botão
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AppButton(
                      onPressed: forgotPassword,
                      label: 'Enviar',
                      width: context.percentWidth(.7),
                      height: context.percentHeight(.06),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
