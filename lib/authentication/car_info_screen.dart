import 'package:chofair_driver/global/global.dart';
import 'package:chofair_driver/splashScreen/splash_screen.dart';
import 'package:chofair_driver/widgets/snack_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});


  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

TextEditingController marcaCarro = TextEditingController();
TextEditingController modeloCarro = TextEditingController();
TextEditingController corCarro = TextEditingController();
TextEditingController placaCarro = TextEditingController();
TextEditingController renavamCarro = TextEditingController();

List<String> anoCarroList = ['2008', '2009', '2010', '2011', '2012', '2013', '2014',
                              '2015', '2016', '2017', '2018', '2019', '2020', '2021',
                              '2022', '2023', '2024'];
String? selectedAnoCarro; 


List<String> serviceType = ['Carro', 'Moto']; 
String? selectedChofairService; 


validateForm() {
    
    if(marcaCarro.text.isEmpty) {
      showRedSnackBar(context, 'Digite a marca do veículo.');
    }
    else if(modeloCarro.text.isEmpty) {
      showRedSnackBar(context, 'Digite o modelo do veículo.');
    }
    else if(corCarro.text.isEmpty) {
      showRedSnackBar(context, 'Digite a cor do veículo.');

    }
    else if(placaCarro.text.isEmpty || placaCarro.text.length != 7) {
      showRedSnackBar(context, 'Digite a placa do veículo corretamente.');
    }
    else if(renavamCarro.text.isEmpty || renavamCarro.text.length != 9 && renavamCarro.text.length  != 11) {
      showRedSnackBar(context, 'Digite o RENAVAM corretamente.');
    }
    else {
      saveCarInfo();
    }
  }

saveCarInfo() {
    Map driverCarInfoMap = { //map cria e adiciona os campos lá no firebase
      "service": selectedChofairService,
      "year": selectedAnoCarro,
      "marca": marcaCarro.text.trim(),
      "modelo": modeloCarro.text.trim(),
      "cor": corCarro.text.trim(),
      "placa": placaCarro.text.trim(),
      "renavam": renavamCarro.text.trim(),
    };
    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
      showGreenSnackBar(context, 'Veículo salvo com sucesso.');
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              SizedBox(
                height: 120, width: 120,
                  child: Image.asset("images/chofairlogo.png")
              ),
                const Text(
                  "REGISTRAR CARRO",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                DropdownButton(
                  dropdownColor: const Color(0xFFFFFFFF),
                  hint: const Text(
                    'Tipo de veículo'),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey
                    ),
                  value: selectedChofairService,
                  onChanged: (snewValue) {
                    setState(() {
                      selectedChofairService = snewValue.toString();
                    });
                  },
                  items: serviceType.map((tipo) {
                    return DropdownMenuItem(
                      value: tipo,
                      child: Text(tipo,
                      style: const TextStyle(color: Color(0xFF222222)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                DropdownButton(
                  dropdownColor: const Color(0xFFFFFFFF),
                  hint: const Text(
                    'Ano de fabricação'),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey
                    ),
                  value: selectedAnoCarro,
                  onChanged: (newValue) {
                    setState(() {
                      selectedAnoCarro = newValue.toString();
                    });
                  },
                  items: anoCarroList.map((ano) {
                    return DropdownMenuItem(
                      value: ano,
                      child: Text(ano,
                      style: const TextStyle(color: Color(0xFF222222)),
                      ),
                    );
                  }).toList(),
                ),
                TextFormField(
                  style: const TextStyle(color: Color(0xFF222222)),
                  controller: marcaCarro,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Marca",
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
                  controller: modeloCarro,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Modelo",
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
                  controller: corCarro,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Cor",
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
                  controller: placaCarro,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Placa",
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
                  controller: renavamCarro,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "RENAVAM",
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
              const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                        if (selectedChofairService == null) {
                          showRedSnackBar(context, 'Escolha o tipo de veículo.');
                      } else if (selectedAnoCarro == null) {
                          showRedSnackBar(context, 'Escolha o ano de fabricação do veículo.');
                      } 
                      else {
                        // Ambos foram selecionados, execute a função validateForm
                        validateForm();
                      }
                
                      },
                    // onPressed: () {
                    //   if(selectedAnoCarro != null)
                    //   {
                    //     validateForm();
                    //   }
                    //   else if (selectedAnoCarro = null) {
                    //   const snackBar = SnackBar(
                    //   content: Text('Escolha o ano de fabricação do veículo.', textAlign: TextAlign.center),
                    //   duration: Duration(seconds: 4),backgroundColor: Colors.red);
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   }
                    //   else (selectedChofairService = null) {
                    //   const snackBar = SnackBar(
                    //   content: Text('Escolha o tipo de veículo.', textAlign: TextAlign.center),
                    //   duration: Duration(seconds: 4),backgroundColor: Colors.red);
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   }
                
                    // },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222222),
                      fixedSize: const Size(180, 45)
                    ),
                    child: const Text(
                      "REGISTRAR",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}