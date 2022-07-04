import 'package:flutter/material.dart';

class Plano extends StatelessWidget {
  const Plano({ Key? key }) : super(key: key);

  @override
   @override
  Widget build(BuildContext context) 
  { 
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Petshop"),
        backgroundColor: Colors.pinkAccent
      ),
      body: Container(
        child: Center(
          child:Column(
          children: [
            SizedBox(height: 50,),
            Card(
              color: Colors.pinkAccent,
              child: SizedBox(
                width: 250,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      
                      Text("Plano Basic", style: TextStyle(fontSize: 30)),
                      Text("99,90/Mensal"),
                      Text("1x Tosa"),
                      Text("3x banhos"),
                      Text("1 animal cadastrado"),
                      ElevatedButton(onPressed: (){}, child: const Text("Assinar"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink))),
                    ],
                  ),
                )),
            ),
            SizedBox(height: 50,),
            Card(
              color: Colors.pinkAccent,
              child: SizedBox(
                width: 250,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text("Plano Premium", style: TextStyle(fontSize: 30)),
                      Text("149,90/Mensal"),
                      Text("2x Tosa"),
                      Text("5x banhos"),
                      Text("3 animais cadastrados"),
                      ElevatedButton(onPressed: (){}, child: const Text("Assinar"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)),),
                    ],
                  ),
                )),
            ),
          ],
        ),
       )
      )
    );
  }
}