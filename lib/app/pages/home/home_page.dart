// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_pmsf/app/helpers/firestore_helper.dart';
import 'package:login_page_pmsf/app/helpers/messages.dart';
import 'package:login_page_pmsf/app/models/user_model.dart';
import 'package:login_page_pmsf/app/pages/home/home_edit_page.dart';
import 'package:login_page_pmsf/app/pages/login/login_page.dart';
import 'package:login_page_pmsf/app/ui/styles/colors_app.dart';
import 'package:login_page_pmsf/app/ui/styles/text_styles.dart';
import 'package:validatorless/validatorless.dart';
import '../../ui/widgets/app_button.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required Null Function() showLoginPage})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Messages{
  final _formKey = GlobalKey<FormState>();
  final _controladorNome = TextEditingController();
  final _controladorEmail = TextEditingController();
  final _controladorSenha = TextEditingController();

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorEmail.dispose();
    super.dispose();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).push(MaterialPageRoute(
      builder: ((context) =>
          LoginPage(showHomePage: () {}, showRegisterPage: () {})),
    ));
  }

  Future<void> signUpHomePage() async {
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
        showError('E-mail já está sendo utilizado por outro usuário');
      }
    }
  }

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            title: Text(
              'Página Inicial',
              style: context.textStyles.textBold.copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: ColorsApp.i.primary,
            leading: IconButton(
              onPressed: signOut,
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
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                controller: _controladorNome,
                validator: Validatorless.required('Nome obrigatório'),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: context.textStyles.textRegular
                      .copyWith(color: Colors.grey[600]),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFF757575), width: 1.35),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                controller: _controladorEmail,
                validator: Validatorless.multiple([
                  Validatorless.email('E-mail inválido'),
                  Validatorless.required('E-mail obrigatório'),
                ]),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: context.textStyles.textRegular
                      .copyWith(color: Colors.grey[600]),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFF757575), width: 1.35),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                controller: _controladorSenha,
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.min(
                      6, 'Senha precisa ter no mínimo 6 caracteres'),
                  Validatorless.required('Senha obrigatória'),
                ]),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: context.textStyles.textRegular
                      .copyWith(color: Colors.grey[600]),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFF757575), width: 1.35),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppButton(
                onPressed: signUpHomePage,
                label: 'Cadastrar',
                width: 120,
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<List<UserModel>>(
                stream: FirestoreHelper.read(),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final userData = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: userData!.length,
                      itemBuilder: (context, index) {
                        final singleUser = userData[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                 return AlertDialog(
                                  title: const Text('Deletar'),
                                  content: const Text(
                                    'Você tem certeza que deseja deletar o usuário?'),
                                    actions: [
                                      AppButton(
                                        label: 'Deletar',
                                        onPressed: () {
                                            FirestoreHelper.delete(singleUser).then((value) => {
                                              Navigator.pop(context)
                                            }
                                          );
                                        }
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: ColorsApp.i.secondary,
                                      shape: BoxShape.circle),
                                ),
                                title: Text("${singleUser.name}"),
                                subtitle: Text(
                                  "${singleUser.email}",
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeEditPage(
                                                user: UserModel(
                                                    name: singleUser.name,
                                                    email: singleUser.email,
                                                    id: singleUser.id))));
                                  },
                                  child: Icon(Icons.edit,
                                      color: context.colors.secondary),
                                ),
                              ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              )]
            ),
          ),
        ),
      );
    }
  }
