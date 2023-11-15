
import 'package:chofair_driver/authentication/login_screen.dart';
import 'package:chofair_driver/widgets/progress_dialog.dart';
import 'package:chofair_driver/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PasswordRecover extends StatefulWidget {
  const PasswordRecover({super.key});


  @override
  State<PasswordRecover> createState() => _PasswordRecoverState();
}

class _PasswordRecoverState extends State<PasswordRecover> {

  TextEditingController emailController = TextEditingController();


validateForm() {
    
    if(!emailController.text.contains('@')) {
      showRedSnackBar(context, 'Utilize um e-mail válido.');
    }
    else {
      resetPassword(emailController.text);
    }
  }

Future<void> resetPassword(String email) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(message: "Processando...");
      },
    );
    // Navigator.pop(context);
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showGreenSnackBar(context, 'Sucesso! Acesse seu e-mail para redefinir sua senha.');
      Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
    
    // E-mail de recuperação de senha enviado com sucesso
  } catch (e) {
    Navigator.pop(context);
    showRedSnackBar(context, 'Digite um e-mail válido.');
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
                  "RECUPERAR SENHA",
                  style: TextStyle(
                    fontSize: 16,
                    color:  Color(0xFF222222),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  //autofocus: true,
                  style: const TextStyle(color: Color(0xFF222222)),
                  controller: emailController,
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
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    fixedSize: const Size(200, 45)
                  ),
                  child: const Text(
                    "ENVIAR",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(height:22),
              TextButton(
                child: const Text(
                  'Voltar à tela inicial',
                  style: TextStyle(color: Color(0xFF222222)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
                },
                )
            ],
          ),
        ),
      ),
    );
  }
}

/* ENTRE O LOGINUSERNOW ENTRE O CATCH
 else {
      Navigator.pop(context);
      // Fluttertoast.showToast(msg: "Erro ao entrar");
       const snackBar = SnackBar(
          content: Text('Não existe cadastro de passageiro com esse e-mail', textAlign: TextAlign.center),
          duration: Duration(seconds: 6),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
*/ 

//LOGINUSERNOW ANTIGO
/*  loginUserNow() async {
 // try{ trocar pelo try catch
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Processando...");
        }
        );
        
        final User? firebaseUser = (
          await fAuth.signInWithEmailAndPassword(
            email: email.text.trim(),
            password: senha.text.trim(),
          ).catchError((msg){
            Navigator.pop(context);
            Fluttertoast.showToast(msg: 'Error: $msg');
          })
          ).user;
        
          if(firebaseUser != null) {

            DatabaseReference usersRef= FirebaseDatabase.instance.ref().child("users");
            usersRef.child(firebaseUser.uid).once().then((driverKey)
            {
              final snap = driverKey.snapshot;
              if (snap.value != null)
              {
                currentFirebaseUser = firebaseUser;
                const snackBar = SnackBar( //abre snackbar
                  content: Text('Entrada com sucesso', textAlign: TextAlign.center),
                  duration: Duration(seconds: 6), // Duração da exibição do SnackBar
                  backgroundColor: Colors.green);
                  // Exibir o SnackBar na tela
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // Fluttertoast.showToast(msg: "Entrada com sucesso",
                // // toastLength: Toast.LENGTH_LONG, 
                // // gravity: ToastGravity.BOTTOM,
                // // timeInSecForIosWeb: 2,
                // // backgroundColor: Colors.red,
                // // textColor: Colors.white,
                // // fontSize: 15,
                // );
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
              }
               else {
            Fluttertoast.showToast(msg: "Não existe cadastro de passageiro com esse e-mail");
            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
          }
            }); 
            
          }
          else {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "Erro ao entrar");
          }
  }*/