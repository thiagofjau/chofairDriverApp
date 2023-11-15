import 'dart:async';
import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/push_notifications/push_notification_system.dart';
import 'package:chofair_driver/widgets/snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

GoogleMapController? newGoogleMapController;
final Completer<GoogleMapController> _controllerGoogleMap = Completer();


static const CameraPosition _jau = CameraPosition(
    target: LatLng( -22.2963, -48.5587),
    zoom: 14.4746,
  );

  Position? driverCurrentPosition;
  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  String statusText = "Conectar";
  Color buttonColor = const Color(0xFF222222);
  bool isDriverActive = false;
  

  //toogletab
  int selectedIndex = 0;

//cleanTheme
cleanThemeGoogleMap() {
  newGoogleMapController!.setMapStyle('''
                    [  {
    "featureType": "administrative",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#d6e2e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#cfd4d5"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#7492a8"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "lightness": 25
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#dde2e3"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#cfd4d5"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#dde2e3"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#7492a8"
      }
    ]
  },
  {
    "featureType": "landscape.natural.terrain",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#dde2e3"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.icon",
    "stylers": [
      {
        "saturation": -100
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#588ca4"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a9de83"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#bae6a1"
      }
    ]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#c6e8b3"
      }
    ]
  },
  {
    "featureType": "poi.sports_complex",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#bae6a1"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "saturation": -45
      },
      {
        "lightness": 10
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#41626b"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#c1d1d6"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#a6b5bb"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#9fb6bd"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.icon",
    "stylers": [
      {
        "saturation": -70
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b4cbd4"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#588ca4"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#008cb5"
      }
    ]
  },
  {
    "featureType": "transit.station.airport",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": -5
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a6cbe3"
      }
    ]
  }
]
                ''');
            
}

  checkIfLocationPermissionAllowed() async {
  _locationPermission = await Geolocator.requestPermission();

  if(_locationPermission == LocationPermission.denied)
  {
    _locationPermission = await Geolocator.requestPermission();
  }
}

locateDriverPosition() async {
  //aqui pega a posicao atual do user
 Position cPosition =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
 driverCurrentPosition = cPosition;

 LatLng latLngPosition = LatLng(driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);
 CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);

 newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
 

  //COM AS LINHAS ABAIXO DÁ ERRO NO PROVIDER, SE TOCAR EM OUTRA PAGINA FECHOU APP?
//   if (mounted) {
//   String humanReadableAddress = await AssistantMethods.searchAddressForGeoCoordinates(driverCurrentPosition!, context);
//   print("Este é o Meu Endereço: " + humanReadableAddress);
// }
  // String humanReadableAddress = await AssistantMethods.searchAddressForGeoCoordinates(driverCurrentPosition!, context);
  //  print("ESTe é o Meu Endereço: " + humanReadableAddress);
}

readCurrentDriverInformation() async {
  currentFirebaseUser = fAuth.currentUser;
  PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
  pushNotificationSystem.initializeCloudMessaging(context); //inicializa CloudMessaging criado em pushnotificationsystem
  pushNotificationSystem.generateAndGetToken();
}

@override
  void initState() {
    super.initState(); 
    checkIfLocationPermissionAllowed(); //permissão para localização method
    readCurrentDriverInformation(); //chama method do CM   
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _jau,
          onMapCreated: (GoogleMapController controller) {
          _controllerGoogleMap.complete(controller);
          newGoogleMapController = controller;

            //clean theme Google Map
            cleanThemeGoogleMap();

            locateDriverPosition();
          },
          ),

          //UI for online-offline driver
          statusText != "Desconectar" ? Container(
            //container offline mapa blurry
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: const Color.fromARGB(162, 255, 255, 255),
          ) 
          : Container(

          ),

          //button online-online driver
          Positioned(
            top: statusText != "Desconectar" 
            ? MediaQuery.of(context).size.height * 0.45
            : 25,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70,),
                ElevatedButton(
                  onPressed: () {
                    driverIsOnlineNow(); //método chamado aqui para online receber requests de corridas
                    updateDriversLocationAtRealtime();

                    if(isDriverActive != true) //se estiver offline
                    {
                      driverIsOnlineNow(); 
                      updateDriversLocationAtRealtime();

                      setState(() {
                        statusText = "Desconectar";
                        isDriverActive = true;
                        buttonColor = const Color(0xFF222222);
                      });

                      //display snackbar
                      showGreenSnackBar(context, 'Você se conectou.');
                    }
                    else {
                      driverIsOfflineNow();
                      setState(() {
                        statusText = "Conectar";
                        isDriverActive = false;
                        buttonColor = const Color(0xFF222222);
                        const Icon(
                        Icons.phonelink_erase_sharp,
                        color: Colors.white,
                        size: 26,
                      );
                      });
                      //display snackbar
                      showRedSnackBar(context, 'Você se desconectou.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding:  const EdgeInsets.symmetric(horizontal: 28),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(26),
                    // ),
                    fixedSize: const Size(190, 40),
                  ),
                  child: statusText != "Desconectar" 
                  ? Text(
                    statusText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:  Colors.white,
                    ),
                  )
                  : const Row(
                    children: [
                       Icon(
                        Icons.phonelink_erase_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                      Text(
                    "Desconectar",
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:  Colors.white,
                    ),
                  )
                    ],
                  ),
                  ),
              ],
            ),
          )
      ],
    );
  }

  driverIsOnlineNow() async { //chamado quando driver clica pra ficar online e display todos drivers perto para os user no app users

    //pegar a posição do driver
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    driverCurrentPosition = pos;

    Geofire.initialize("activeDrivers"); //inicializa geofire e activeDrivers como está na regra criada no firebase
    Geofire.setLocation(currentFirebaseUser!.uid, 
    driverCurrentPosition!.latitude, 
    driverCurrentPosition!.longitude
    );

    DatabaseReference ref = FirebaseDatabase.instance.ref()
    .child("drivers")
    .child(currentFirebaseUser!.uid)
    .child("newRideStatus"); //referenciar driver buscando nova corrida

    ref.set("idle"); //idle está pronto para requests de corrida
    //abaixo se os requests de corride continuam vindo ele está 'ouvindo' para aceitar ou rejeitar request
    ref.onValue.listen((event) { });
  }

  //versão 1 de updateDriversLocationAtRealTime
  // updateDriversLocationAtRealtime() { //atualizar location do driver em realtime
  //   streamSubscriptionPosition = Geolocator.getPositionStream()
  //   .listen((Position position) 
  //   { 
  //     driverCurrentPosition = position;

  //     if(isDriverActive == true) {
  //       Geofire.setLocation(
  //       currentFirebaseUser!.uid,
  //       driverCurrentPosition!.latitude, 
  //       driverCurrentPosition!.longitude
  //   );
  //     }
      
  //     LatLng latLng = LatLng(
  //         driverCurrentPosition!.latitude,
  //         driverCurrentPosition!.longitude,
  //     );

  //     newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));

  //   });
  // }


  //testar updateDriversLocationAtRealtime nova
  void updateDriversLocationAtRealtime() {
  // Assine a transmissão de posições do driver
  streamSubscriptionPosition = Geolocator.getPositionStream().listen((Position position) {
    // Atualize a posição atual do motorista
    driverCurrentPosition = position;

    if (isDriverActive) {
      // Se o motorista estiver ativo, atualize a localização no Geofire
      Geofire.setLocation(
        currentFirebaseUser!.uid,
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude,
      );
    }

    // Atualize a posição do mapa
    updateMapPosition();
  });
}

void updateMapPosition() {
  if (driverCurrentPosition != null) {
    LatLng latLng = LatLng(
      driverCurrentPosition!.latitude,
      driverCurrentPosition!.longitude,
    );

    // Anima a câmera para a nova posição
    newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
  }
}



  void driverIsOfflineNow() async {
  // Remove a localização do motorista do "activeDrivers" usando Geofire
  await Geofire.removeLocation(currentFirebaseUser!.uid);

  // Acesse a referência do Firebase
  DatabaseReference driverRef = FirebaseDatabase.instance.ref()
      .child("drivers")
      .child(currentFirebaseUser!.uid);

  // Remova o nó "newRideStatus"
  DatabaseReference newRideStatusRef = driverRef.child("newRideStatus");
  await newRideStatusRef.remove();

  // Remova o motorista do nó "activeDrivers"
  DatabaseReference activeDriversRef = FirebaseDatabase.instance.ref().child("activeDrivers");
  await activeDriversRef.child(currentFirebaseUser!.uid).remove();
}

}





// //teste2 remover CONTINUAR TESTANDO ESSA PORRA! ATE EXCLUIR, VER O VIDEO DO PAKISTANEEZ SAFADO
// driverIsOfflineNow() {
//   Geofire.removeLocation(currentFirebaseUser!.uid);
  
//   DatabaseReference ref = FirebaseDatabase.instance.ref()
//       .child("drivers")
//       .child(currentFirebaseUser!.uid)
//       .child("newRideStatus");

//   // Configurar a ação de desconexão antes de remover os dados
//   ref.onDisconnect().remove();

//   // Remover os dados imediatamente
//   ref.remove();

//   Future.delayed(const Duration(milliseconds: 2000), () {
//     //SystemNavigator.pop();
//     SystemChannels.platform.invokeMethod("SystemNavigator.pop");
//     // Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
//   });
// }


//   //driver offline corrigido, testar se remove do firebase ao desconetar:
//   driverIsOfflineNow() {
//   DatabaseReference ref = FirebaseDatabase.instance.reference()
//       .child("drivers")
//       .child(currentFirebaseUser!.uid);

//   // Use onDisconnect() para definir o que fazer quando o motorista desconectar.
//   ref.onDisconnect().update({"newRideStatus": null});

//   // Esperar um curto período de tempo antes de fechar o aplicativo.
//   Future.delayed(const Duration(milliseconds: 2000), () {
//     // Fecha o aplicativo.
//     SystemNavigator.pop();
//   });
// }



//FUNCIONOU PARA newRideStatus
// void driverIsOfflineNow() async {
//   // Remove a localização do motorista do "activeDrivers" usando Geofire
//   await Geofire.removeLocation(currentFirebaseUser!.uid);

//   // Remove o nó "newRideStatus" do motorista
//   DatabaseReference newRideStatusRef = FirebaseDatabase.instance.ref()
//       .child("drivers")
//       .child(currentFirebaseUser!.uid)
//       .child("newRideStatus");
//   await newRideStatusRef.remove();

//   print("Dados do motorista removidos com sucesso.");
// }

//testar para newridestatus e id do activedrivers





  // driverIsOfflineNow() {
  //   Geofire.removeLocation(currentFirebaseUser!.uid);

  //   DatabaseReference? ref = FirebaseDatabase.instance.ref()
  //       .child("drivers")
  //       .child(currentFirebaseUser!.uid)
  //       .child("newRideStatus"); //referenciar driver buscando nova corrida
  //   ref.remove();
    
  //   ref.onDisconnect();
  //   ref = null;

  //   Future.delayed(const Duration(milliseconds: 2000), () {
  //     // SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  //     // SystemNavigator.pop();

  //     //Recomedado não usar essa linha, e sim fechar app como a de cima
  //     Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen())); 
  //   });
    
  // }