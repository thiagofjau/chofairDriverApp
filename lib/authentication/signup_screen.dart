import 'package:chofair_driver/authentication/car_info_screen.dart';
import 'package:chofair_driver/authentication/login_screen.dart';
import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/widgets/progress_dialog.dart';
import 'package:chofair_driver/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController senha = TextEditingController();

  validateForm() {
    if(nome.text.length < 3) {
      showRedSnackBar(context, 'Digite seu nome completo.');
    }
    else if(!email.text.contains('@')) {
      showRedSnackBar(context, 'Digite um e-mail válido.');
    }
    else if(celular.text.isEmpty || celular.text.length < 10 || celular.text.length >15) {
      showRedSnackBar(context, 'Digite um número válido com DDD.');
    }
    else if(senha.text.length < 6) {
      showRedSnackBar(context, 'A senha deve ter no mínimo 6 caracteres.');
    }
    else {
      saveDriverInfoNow(context);
    }
  }

//substituído pelo try-catch. TESTAR
  saveDriverInfoNow(context) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(message: "Processando...");
      },
    );
    
    final UserCredential userCredential = await fAuth.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: senha.text.trim(),
    );

    final User? firebaseUser = userCredential.user;

    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nome.text.trim(),
        "email": email.text.trim(),
        "phone": celular.text.trim(),
      };
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      await driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;

      showGreenSnackBar(context, 'Conta criada com sucesso.');
      Navigator.push(context, MaterialPageRoute(builder: (c) => const CarInfoScreen()));
    } 
  } catch (e) {
    Navigator.pop(context);
    showRedSnackBar(context, 'Não foi possível criar sua conta.');
  }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("images/chofairlogo.png",
                  height: 250,
                  width: 250,
                  fit: BoxFit.fitWidth),
              ),
              //const SizedBox(height: 10),
              const Text(
                "REGISTRE-SE",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xFF222222)),
                controller: nome,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF222222))),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                ),
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xFF222222)),
                controller: email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF222222))),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xFF222222)),
                controller: celular,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Celular",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF222222))),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextFormField(
                style: const TextStyle(color: Color(0xFF222222)),
                controller: senha,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF222222))),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222222),
                  // fixedSize: Size(width, height)
                ),
                child: const Text(
                  "CRIAR CONTA",
                  style: TextStyle(
                    color: Color(0xFFE9E9E9),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            TextButton(
                child: const Text(
                  'Já tem uma conta? Acesse aqui!',
                  style: TextStyle(color:  Color(0xFF222222)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                },
                )
            ],
          ),
        ),
      ),
    );
  }
}



//sem try-catch e com aviso:
// saveDriverInfoNow() async {
//  // try{ trocar pelo try catch O PRIMEIRO E QUE FUNCIONA APESAR DO AVISO
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext c) {
//           return ProgressDialog(message: "Processando...");
//         }
//         );
        
//         final User? firebaseUser = (
//           await fAuth.createUserWithEmailAndPassword(
//             email: email.text.trim(),
//             password: senha.text.trim(),
//           ).catchError((msg){
//             Navigator.pop(context);
//             Fluttertoast.showToast(msg: 'Error: $msg');
//           })
//           ).user;
        
//           if(firebaseUser != null) {
//             Map driverMap = {
//               "id": firebaseUser.uid,
//               "name": nome.text.trim(),
//               "email": email.text.trim(),
//               "phone": celular.text.trim(),
//             };
//             DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
//             driversRef.child(firebaseUser.uid).set(driverMap);

//             currentFirebaseUser = firebaseUser;
//             const snackBar = SnackBar(
//               content: Text('Conta criada com sucesso.', textAlign: TextAlign.center),
//               duration: Duration(seconds: 4),backgroundColor: Colors.red);
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             // Fluttertoast.showToast(msg: "Conta criada com sucesso");
//             // ignore: use_build_context_synchronously
//             Navigator.push(context, MaterialPageRoute(builder: (c)=> CarInfoScreen()));
//           }
//           else {
//             // ignore: use_build_context_synchronously
//             Navigator.pop(context);
//             Fluttertoast.showToast(msg: "Não foi possível criar sua conta");
//           }
//   }