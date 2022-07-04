import 'package:flutter/material.dart';

class Config extends StatelessWidget
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
                  child: ElevatedButton(onPressed: (){}, child: Text("Contato"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ))
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){}, child: Text("Notificações"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ))
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){}, child: Text("Como Utilizar"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ))
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){}, child: Text("Sobre"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ))
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(onPressed: (){}, child: Text("Reportar Problema"), style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                  ))
                ),
              ],
            ),
          ),
      )
    );
  }
}