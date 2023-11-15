import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity, height: 45,
        child: ElevatedButton(
          
          style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222222),
                      padding:  const EdgeInsets.symmetric(horizontal: 48),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(26))
                        ),
      
          child:  const Text("SAIR"),
          onPressed: () {
            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
          },
        ),
      ),
    );
  }
}