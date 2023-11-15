import 'package:chofair_driver/authentication/password_recover.dart';
import 'package:chofair_driver/authentication/signup_screen.dart';
import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/splashScreen/splash_screen.dart';
import 'package:chofair_driver/widgets/progress_dialog.dart';
import 'package:chofair_driver/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

validateForm() {
    if(!email.text.contains('@')) {
      showRedSnackBar(context, 'Insira um e-mail válido.');

    }
    else if(senha.text.length < 6) {
    showRedSnackBar(context, 'A senha deve ter no mínimo 6 caracteres.');
    }
    else {
      loginDriverNow(context);
    }
  }

// try{ trocar pelo try catch
loginDriverNow(context) async {
    try {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext c) {
      return ProgressDialog(message: "Processando...");
    },
  );
  
  final UserCredential userCredential = await fAuth.signInWithEmailAndPassword(
    email: email.text.trim(),
    password: senha.text.trim(),
  );

  final User? firebaseUser = userCredential.user;

  if (firebaseUser != null) {
    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    final driverKey = await driversRef.child(firebaseUser.uid).once();
    final snap = driverKey.snapshot;

    if (snap.value != null) {
      currentFirebaseUser = firebaseUser;
      showGreenSnackBar(context, 'Entrada com sucesso.');

      Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    } 
    // else {
    //   Fluttertoast.showToast(msg: "Não existe cadastro de motorista com esse e-mail.");
    //   fAuth.signOut();
    //   Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    // }
  } 
} catch (e) {
  Navigator.pop(context);
  showRedSnackBar(context, 'E-mail ou senha incorretos.');
}



    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext c) {
    //       return ProgressDialog(message: "Entrando. Aguarde por favor...");
    //     }
    //     );
        
    //     final User? firebaseUser = (
    //       await fAuth.signInWithEmailAndPassword(
    //         email: email.text.trim(),
    //         password: senha.text.trim(),
    //       ).catchError((msg){
    //         Navigator.pop(context);
    //         Fluttertoast.showToast(msg: 'Error: $msg');
    //       })
    //       ).user;
        
    //       if(firebaseUser != null) {

    //         DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    //         driversRef.child(firebaseUser.uid).once().then((driverKey)
    //         {
    //           final snap = driverKey.snapshot;
    //           if (snap.value != null)
    //           {
    //             currentFirebaseUser = firebaseUser;
    //             Fluttertoast.showToast(msg: "Entrada com sucesso");
    //             // ignore: use_build_context_synchronously
    //             Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
    //           }
    //            else {
    //         Fluttertoast.showToast(msg: "Não existe cadastro de motorista com esse e-mail");
    //         fAuth.signOut();
    //         Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
    //       }
    //         });  
    //       }
         
    //       else {
    //         // ignore: use_build_context_synchronously
    //         Navigator.pop(context);
    //         Fluttertoast.showToast(msg: "Erro ao entrar. Tente novamente em alguns instantes");
    //       }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Widget para a imagem de fundo em tela inteira
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/driverpic.jpg"), // Substitua pelo caminho da sua imagem de fundo
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Widget para a cor com transparência
        Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
       
        Colors.white.withOpacity(0.83), // Cor superior com transparência
         const Color(0xFFFFFFFF).withOpacity(0.99), 
      ],
    ),
  ),
  child: const SizedBox.expand(), // Isso faz com que o gradiente ocupe todo o espaço disponível
),



          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                   const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset("images/chofairlogo.png",
                      height: 250,
                      width: 250,
                      fit: BoxFit.fitWidth,),
                    ), 
                    const SizedBox(height: 10),
                    const Text(
                      "ENTRAR COMO MOTORISTA",
                      style: TextStyle(
                        fontSize: 16,
                        color:  Color(0xFF222222),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          color: Color(0xFF222222),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
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
                          color: Color(0xFF222222),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  SizedBox(
                    width: double.infinity, height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        validateForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF222222),
                        fixedSize: const Size(180, 45)
                      ),
                      child: const Text(
                        "ENTRAR",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextButton(
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Color(0xFF222222), fontSize: 11),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => const PasswordRecover()));
                    },
                    ),
                  TextButton(
                    child: const Text(
                      'Ainda não tem uma conta? Crie agora!',
                      style: TextStyle(color: Color(0xFF222222)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => SignUpScreen()));
                    },
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}