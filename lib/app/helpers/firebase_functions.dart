
// import 'package:flutter/material.dart';

// class FirebaseFunctions {
  
//
//   Future singIn() async {

//     showDialog(
//       context: context, 
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     );
  
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _controladorEmail.text.trim(),
//         password: _controladorSenha.text.trim(),
//       );

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (
//             (context) => HomePage(
//               showLoginPage: () {},
//             )
//           ),
//         )
//       );
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);

//       if (e.code == 'user-not-found') {
//         showError('Usuário não encontrado');
//         log('user not found');
//       }
//       if (e.code == 'wrong-password') {
//         showError('Senha incorreta');
//         log('user password is wrong');
//       }
//       if (e.code == 'unknown')  {
//         showError('E-mail ou senha incorretos');
//         log('wrong e-mail or password');
//       }
//     }
//   }
// }