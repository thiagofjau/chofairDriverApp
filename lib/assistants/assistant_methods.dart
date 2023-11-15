
import 'package:chofair_driver/assistants/request_assistant.dart';
import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/global/map_key.dart';
import 'package:chofair_driver/info_handler/app_info.dart';
import 'package:chofair_driver/models/direction_details_info.dart';
import 'package:chofair_driver/models/directions.dart';
import 'package:chofair_driver/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AssistantMethods
{

  static Future<String> searchAddressForGeoCoordinates(Position position, context) async {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
    if(requestResponse != "Sem resposta. Tente mais tarde") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
    .ref()
    .child("users")
    .child(currentFirebaseUser!.uid);

    userRef.once().then((snap)
    {
      if (snap.snapshot.value != null) 
      {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);        
      }
    });
  }
  //pegar origem to destination para traçar rota usando API Direction Google
  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(LatLng originPosition, LatLng destinationPosition) async {
    String urlOriginToDestinationDirectionDetails = 
    "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";
  
    var responseDirectionApi = await RequestAssistant.receiveRequest(urlOriginToDestinationDirectionDetails);

    if(responseDirectionApi == "Sem resposta. Tente mais tarde") {
      return null;
    }
    //receber resposta da API Directions
    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points = responseDirectionApi["routes"][0]["overview_polyline"]["points"];
    
     directionDetailsInfo.distance_text = responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
     directionDetailsInfo.distance_value = responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

     directionDetailsInfo.duration_text = responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
     directionDetailsInfo.duration_value = responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];

     return directionDetailsInfo;
  }

} 