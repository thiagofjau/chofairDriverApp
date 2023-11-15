import 'package:chofair_driver/models/user_ride_request_information.dart';
import 'package:flutter/material.dart';

class NotificationDialogBox extends StatefulWidget {
  // const NotificationDialogBox({super.key});

  UserRideRequestInformation? userRideRequestDetails;
  NotificationDialogBox({super.key, this.userRideRequestDetails});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: Colors.white, //cor da borda
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white //cor de fundo brackground
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/Carro.png",
            width: 85, height: 85,
            ),
            const SizedBox(height: 10),
            const Text(
              "Nova Corrida",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 2.0),

            Padding(
              // padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //origin location with icon
                  Row(
                    children: [
                      Image.asset(
                        "images/origin.png",
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(height: 15, width: 15),
                      Expanded(
                        child: Text(
                          widget.userRideRequestDetails!.originAddress!,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
            
                  const SizedBox(height: 30.0),
                  //destination location with icon
                  Row(
                    children: [
                      Image.asset(
                        "images/destination.png",
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(height: 15, width: 15),
                      Expanded(
                        child: Text(
                          widget.userRideRequestDetails!.destinationAddress!,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),


            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Divider(
                height: 3,
                thickness: 1,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, //cor fundo botão. Tentar colocar o botão de fechar lá em cima, radius 100% e icon X close
                      elevation: 2,
                      fixedSize: const Size(105, 15)
                    ),
                onPressed: () {
                  //recusar solicitação
                  Navigator.pop(context);
                }, 
                child: Text(
                  "Recusar".toUpperCase(),
                )
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, //cor fundo botão
                      elevation: 2,
                      fixedSize: const Size(105, 15)
                    ),
                onPressed: () {
                  //recusar solicitação
                  Navigator.pop(context);
                }, 
                child: Text(
                  "Aceitar".toUpperCase(),
                )
                ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}