import 'package:chofair_driver/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_handler/app_info.dart';

//ARGB em material color
Map<int, Color> color = {
  50:  const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromARGB(75, 136, 14, 79),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color(0xFF222222),
};
MaterialColor colorCustom = MaterialColor(0xFF222222, color);

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(

//name: 'chofair-app',
// options: const FirebaseOptions(
// apiKey: "AIzaSyBNy4XI5eRXv7WXPFlkx45p5SIfxvU6N5s",
// appId: "",
// messagingSenderId: "",
// projectId: "")
);
//voltou a funcionar após inserção dos parâmetros do initializapp



  runApp(
    MyApp(
        child: ChangeNotifierProvider(
          create: (context) => AppInfo(),
          child: MaterialApp(
              title: 'Chofair driver',
              theme: ThemeData(
          primarySwatch: colorCustom,
              ),
              home: const MySplashScreen(),
              debugShowCheckedModeBanner: false,
            ),
        )),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  MyApp({key, this.child});

//reiniciar app, global variáveis e métodos, por conta de muitas telas criadas
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
