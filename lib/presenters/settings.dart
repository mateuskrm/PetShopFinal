import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/config.dart';

class Settings extends StatelessWidget
{



  @override
  Widget build(BuildContext context) 
  { 

    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Petshop"),
        backgroundColor: Colors.pinkAccent
      ),
      body: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 400,  
                  child: ElevatedButton(onPressed: (){}, child: Text("Editar dados da conta"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ),),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){}, child: Text("Editar pagamento"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ),),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){}, child: Text("Historico de compras"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ),),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Config()));}, child: Text("configurações da Conta"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ),),
                ),
              ],
            ),
          ),
      ),
     
    );
  }
}