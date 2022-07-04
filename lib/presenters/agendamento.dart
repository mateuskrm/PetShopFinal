import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';

import 'main.dart';

class Agendamento extends StatelessWidget {
  DatabasePet pet;
  DatabaseUser dono;
  DateTime? _dateTime;
   final List<String> servicoOptions = ["Banho", "Tosa"]; 

  String selectedServicoOption ="";
  Agendamento({required this.dono, required this.pet});
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Meu Petshop"),
            backgroundColor: Colors.pinkAccent,
            
          ),
        body:Container(
         
          
          child:Center(
            
            
            child: Card(
              color: Colors.pinkAccent,
              child: SizedBox(   
                height: 350,
                width: 350,           
              child:Form (
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text("Agendar atendimento", style: TextStyle(
                    fontSize: 25,
                  )
                ),
                const SizedBox(height: 20),
                StatefulBuilder(
                  builder: (BuildContext contex, StateSetter setState)
                  {
                    return Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.pink),),
                          onPressed: () async
                        { 
                          final now = DateTime.now();
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(now.year, now.month+1, 0),
                          ).then((value) => setState((() {
                            _dateTime = value;
                          })));
                        },
                          child: Text("Escolha uma Data"),
                        ),
                        const SizedBox(height: 20),
                        Text(_dateTime == null ? "Selecione a data" : _dateTime.toString()),
                        Container(
                          height: 50,
                          child: CheckboxListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: const Text("Leva/Traz"),
                            value: isChecked,
                            onChanged: (bool? value){
                              setState((){isChecked = value!;}); 
                            },
                          ),          
                        ),
                        Row(
                            children: 
                            [ 
                              
                               ...servicoOptions.map<Widget>((element) => 
                               Flexible(
                                child: RadioListTile(
                                 title: Text(element),
                                groupValue: selectedServicoOption,onChanged: (String? e){  
                                  setState((){selectedServicoOption = e!;});
                                },value: element,
                               )
                              ,)
                              ).toList()
                            ],
                           
                          )
                      ],
                    );
                  },
                ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: (){
                final agenda = Services().createAgenda(pet: pet, servico: selectedServicoOption, data: _dateTime!.toString(), entregaDomicilio: isChecked == false ? "true":"false");
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(dono: dono)));
              }, child: Text("Agendar"), style: ButtonStyle(
                 backgroundColor:MaterialStateProperty.all<Color>(Colors.pink),
              ),)
            ],
          )
        )
      )
     )
    )
    )
    );
  }
}
