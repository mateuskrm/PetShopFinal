import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/main.dart';
import 'package:projeto_pet_shop/presenters/pet_view.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';

import 'cadastro_animal.dart';
class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        color: Colors.pinkAccent,
        child: Form(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: 
                Text("Usuário",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50), 
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Insira o nome do Usuário"            ),
                )
              
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: 
                  Text("Senha",
                    style: TextStyle(fontSize: 25),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50), 
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Insira a senha"            
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child:ElevatedButton(
                  onPressed: () async {
                    final user = await Services().createUser(email: emailController.text, password: passwordController.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(dono: user,)));
                  },
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                child: const Text("Entrar")
              ),   
            )
          ],
        ),
      ),
    );
  }
}