import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/models/user_ride_request_information.dart';
import 'package:chofair_driver/push_notifications/notification_dialog_box.dart';
import 'package:chofair_driver/widgets/snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // BuildContext context;

  // PushNotificationSystem(this.context);

  

  Future initializeCloudMessaging(BuildContext context) async {
    //1. terminated state
    //quando o app está completamente fechado e abre direto da notificação push
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage){
      if(remoteMessage != null) {
        //display the ride request information - user information who request a ride
        readUserRideRequestInformation(remoteMessage.data["rideRequestId"], context);
      }
    });

    //2. foreground state
    //quando está aberto e na tela e recebe notificação
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {

      //display the ride request information - user information who request a ride
      readUserRideRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });

    //3. background state
    //app aberto, msa em outra tela de outro app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) { 

      //display the ride request information - user information who request a ride
      readUserRideRequestInformation(remoteMessage!.data["rideRequestId"], context);

    });
  }

  readUserRideRequestInformation(String userRideRequestId, BuildContext context) {
    FirebaseDatabase.instance.ref()
      .child("All Ride Requests").child(userRideRequestId)
      .once()
      .then((snapData) {
        if(snapData.snapshot.value != null) {
         double originLat = double.parse((snapData.snapshot.value! as Map)["origin"]["latitude"]);
         double originLng = double.parse((snapData.snapshot.value! as Map)["origin"]["longitude"]);
         String originAddress = (snapData.snapshot.value! as Map)["originAddress"];
         
         double destinationLat = double.parse((snapData.snapshot.value! as Map)["destination"]["latitude"]);
         double destinationLng = double.parse((snapData.snapshot.value! as Map)["destination"]["longitude"]);
         String destinationAddress = (snapData.snapshot.value! as Map)["destinationAddress"];

         String userName = (snapData.snapshot.value! as Map)["userName"];
         String userPhone = (snapData.snapshot.value! as Map)["userPhone"];

         UserRideRequestInformation userRideRequestDetails = UserRideRequestInformation();
         userRideRequestDetails.originLatLng = LatLng(originLat, originLng);
         userRideRequestDetails.originAddress = originAddress;
         userRideRequestDetails.destinationLatLng = LatLng(destinationLat, destinationLng);
         userRideRequestDetails.destinationAddress = destinationAddress;
         userRideRequestDetails.userName = userName;
         userRideRequestDetails.userPhone = userPhone;

         showDialog(
          context: context,
          builder: (BuildContext context) => NotificationDialogBox(
            userRideRequestDetails: userRideRequestDetails
          ),
           );
        }
        else {
          showRedSnackBar(context, "Esta solicitação de corrida não está mais disponível.");
        }
      });

  }

  Future generateAndGetToken() async {
   String? registrationToken = await messaging.getToken();
   print('Token de registro FCM: ');
   print(registrationToken);
   FirebaseDatabase.instance.ref()
   .child("drivers").child(currentFirebaseUser!.uid)
   .child("token")
   .set(registrationToken);

   messaging.subscribeToTopic("allDrivers");
   messaging.subscribeToTopic("allUsers");
  }
}



/*código do postman

{
    "notification":{
        "body":"Hello, world! Você tem uma nova solicitação de corrida! Bora?",
        "title":"Chofair - Motorista"
      },
      "priority": "high",
      "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done",
          "rideRequestId": "APA91bGq6l4OMclRbOH9EWqrOJHqioU98kpYg9NTJrkq0bIH4X3BBqaI5UuVvY0lmp_DWdA5aeRR8YVpN388P6TQ5AlX7xJqvMMfFS2_2TOZoruTWM2qXHaucGXkhJau6EiMr44U4BdA"
      },
      "to": ""
}*/