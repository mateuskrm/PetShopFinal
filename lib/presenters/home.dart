import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/planos.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';

class Home extends StatelessWidget {
  
  Home({required this.dono});
  DatabaseUser dono;
  int qtdpets = 0;
  @override
  void initState()
  {
    _getqtdpets();
  }
  Future<void> _getqtdpets() async
  {
    final pets = await Services().getAllPets(dono: dono);
    qtdpets = pets.length;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Petshop"),
        backgroundColor: Colors.pinkAccent,
      ),
      body:  Center(
          child: SizedBox(

            width: 300,
            height: 200,
            child: Container(
              color: Colors.pinkAccent,
              child:Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Bem vindo " + dono.email, style: TextStyle(fontSize: 30),),
                    Text("Você tem direito a 1 tosa e 3 Banhos"),
                    Text("Seu plano expira em 10 dias"),
                    Text("Você possui " + qtdpets.toString() + " pets cadastrados"),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Plano()));}, child: Text("Editar Plano"),style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                    )
                  )
                ],
              ),
            )
          ),
        )
      )
    );
  }
}