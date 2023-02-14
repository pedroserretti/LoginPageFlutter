import 'package:flutter/material.dart';
import 'package:login_page_pmsf/app/helpers/firestore_helper.dart';
import 'package:login_page_pmsf/app/ui/styles/text_styles.dart';
import '../../models/user_model.dart';
import '../../ui/widgets/app_button.dart';

class HomeEditPage extends StatefulWidget {
  final UserModel user;
  const HomeEditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeEditPage> createState() => _HomeEditPageState();
}

class _HomeEditPageState extends State<HomeEditPage> {
  TextEditingController? _controladorNome;
  TextEditingController? _controladorEmail;

  @override
  void initState() {
    _controladorNome = TextEditingController(text: widget.user.name);
    _controladorEmail = TextEditingController(text: widget.user.email);

    super.initState();
  }

  @override
  void dispose() {
    _controladorNome!.dispose();
    _controladorEmail!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text('Editar Usuário'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                controller: _controladorNome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: context.textStyles.textRegular
                      .copyWith(color: Colors.grey[600]),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.greenAccent, width: 1.35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextFormField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: context.textStyles.textRegular
                    .copyWith(color: Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1.35),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.greenAccent, width: 1.35),
                  borderRadius: BorderRadius.circular(15),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0), 
            child: AppButton(
              onPressed: () {
                FirestoreHelper.update(UserModel(id: widget.user.id, name: _controladorNome!.text, email: _controladorEmail!.text),).then((value) {
                  Navigator.pop(context);
                });
              },
              label: 'Atualizar',
              width: 120,
              height: 50,
            ),
          ),
          ]),
        ),
      ),
    );
  }
}
