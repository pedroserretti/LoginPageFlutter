// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_pmsf/app/helpers/messages.dart';
import 'package:login_page_pmsf/app/pages/home/home_page.dart';
import 'package:login_page_pmsf/app/pages/login/login_page.dart';
import 'package:login_page_pmsf/app/ui/styles/text_styles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:validatorless/validatorless.dart';
import '../../components/home_modal_add.dart';
import '../../helpers/firestore_helper.dart';
import '../../models/user_model.dart';
import '../../ui/styles/colors_app.dart';
import '../../ui/widgets/app_button.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Messages{
  bool _obscureText = true;
  bool acceptTerms = false;
  final _formKey = GlobalKey<FormState>();
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();
  final _controladorConfirmarSenha = TextEditingController();
  final _controladorNome = TextEditingController();

  routeTransition(showLoginPage) {
    Navigator.push(
      context,
      PageTransition(
        child: LoginPage(
          showHomePage: () {},
          showRegisterPage: () {},
        ),
        type: PageTransitionType.leftToRight,
      ),
    );
  }

  Future termsAndConditions() async {
    await showBarModalBottomSheet(
        context: context, builder: (context) => HomeModalAdd());
  }

  Future<void> signUp() async {
    try {
      var formValid = _formKey.currentState?.validate() ?? false;

      if (formValid) {
        await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _controladorEmail.text.trim(),
            password: _controladorSenha.text.trim())
          .then((UserCredential userCredential) {
            userCredential.user!.updateDisplayName(_controladorNome.text);

            FirestoreHelper.create(UserModel(
              name: _controladorNome.text.trim(),
              email: _controladorEmail.text.trim(),
              password: _controladorSenha.text.trim(),
              )
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(showLoginPage: () {}),
              ),
              (route) => false);
            showSuccess('Cadastro realizado com sucesso, bem vindo!');
          }
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showError('E-mail j?? est?? sendo utilizado por outro usu??rio');
      }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                  ),

                  SizedBox(height: 10),

                  // ol?? novamente!
                  Text(
                    'Registre-se',
                    style:
                        context.textStyles.textExtraBold.copyWith(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style:
                        context.textStyles.textRegular.copyWith(fontSize: 14),
                  ),

                  SizedBox(height: 30),

                  // campo para digitar o nome
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _controladorNome,
                      validator: Validatorless.required('Nome obrigat??rio.'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: context.textStyles.textRegular
                            .copyWith(color: Colors.grey[600]),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF757575), width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsApp.i.primary, width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // campo para digitar o e-mail
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _controladorEmail,
                      validator: Validatorless.multiple([
                        Validatorless.email('E-mail inv??lido.'),
                        Validatorless.required('E-mail obrigat??rio.'),
                      ]),
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
                              color: ColorsApp.i.primary, width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // campo para digitar a senha
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: _controladorSenha,
                      validator: Validatorless.multiple([
                        Validatorless.min(6,
                            'A senha precisa conter no m??nimo 6 caracteres.'),
                        Validatorless.required('Senha obrigat??ria.'),
                      ]),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }, 
                        icon: Icon(
                          _obscureText? Icons.visibility: 
                          Icons.visibility_off, 
                          color: Colors.green,
                        ),
                      ),
                        labelText: 'Senha',
                        labelStyle: context.textStyles.textRegular
                            .copyWith(color: Colors.grey[600]),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF757575), width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsApp.i.primary, width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // campo para confirmar a senha
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: _controladorConfirmarSenha,
                      validator: Validatorless.compare(
                          _controladorSenha, 'As senhas devem ser iguais.'),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }, 
                        icon: Icon(
                          _obscureText? Icons.visibility: 
                          Icons.visibility_off, 
                          color: Colors.green,
                        ),
                      ),
                        labelText: 'Confirmar senha',
                        labelStyle: context.textStyles.textRegular
                            .copyWith(color: Colors.grey[600]),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF757575), width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorsApp.i.primary, width: 1.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // termos e condi????es.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        activeColor: ColorsApp.i.primary,
                        onChanged: (bool? checked) {
                          setState(() {
                            acceptTerms = checked!;
                          });
                        },
                      ),
                      Text(
                        'Eu li e concordo com os',
                        style: context.textStyles.textRegular
                            .copyWith(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: termsAndConditions,
                        child: Text(
                          ' Termos e Condi????es.',
                          style: context.textStyles.textBold
                              .copyWith(fontSize: 14, color: ColorsApp.i.secondary),
                        ),
                      ),
                    ],
                  ),

                  // bot??o cadastrar
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AppButton(
                      onPressed: !acceptTerms ? null : signUp,
                      label: 'Cadastrar',
                      width: 370,
                      height: 50,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // bot??o voltar para login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'J?? tem uma conta?',
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () => {
                          routeTransition(widget.showLoginPage),
                        },
                        child: Text(
                          ' Fa??a seu login!',
                          style: context.textStyles.textBold
                              .copyWith(fontSize: 14, color: ColorsApp.i.secondary),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
          ),
        ),
      );
    }
  }
