import 'dart:async';
import 'package:chofair_driver/authentication/login_screen.dart';
import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/mainScreens/main_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();

}

class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer() {
      Timer(const Duration(seconds: 2), () async {
        if(await fAuth.currentUser != null) { //verificar a expressao await, tirar ela eo async, trocar ou remover
        currentFirebaseUser = fAuth.currentUser;
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
        } else{
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
        }
        
      });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
  return Material(
    child: Container(
      color: const Color(0xFFFFFFFF),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/chofairlogo.png"),
          const SizedBox(height: 10),
          const Text(
            'Dirija e ganhe dinheiro!',
            style: TextStyle(
              fontSize: 28,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ) ,
    ),
    )
    
  );
  }
}