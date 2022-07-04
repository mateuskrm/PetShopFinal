import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/agendamento.dart';
import 'package:projeto_pet_shop/presenters/main.dart';
import 'package:projeto_pet_shop/presenters/pet_view.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';

class CadastroAnimal extends StatelessWidget
{
  final DatabaseUser dono;
  CadastroAnimal({required DatabaseUser this.dono});

  final nome = TextEditingController();

  final List<String> petOptions = ['Cão', 'Gato', 'Ave']; 

  String selectedPetOption ='';

  final List<String> sizeOptions = ['P', 'M', 'G'];

  String selectedSizeOption = '';

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Petshop"),
        backgroundColor: Colors.pinkAccent
      ),
      body: Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width:450,
              height: 450,
              color: Colors.pinkAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      const Text("Cadastrar Novo Pet", style: TextStyle(fontSize: 30)),
                      const SizedBox(height: 10),
                      const Text("Nome", style: TextStyle(fontSize: 15)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: nome,
                        decoration: const InputDecoration(
                          hintText: "Insira o nome do Pet"
                        )
                      ),
                      const SizedBox(height: 10),
                      const Text("Espécie"),
                      const SizedBox(height: 10),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState)
                        {
                          return Row(
                            children: 
                            [ 
                              
                               ...petOptions.map<Widget>((element) => 
                               Flexible(
                                child: RadioListTile(
                                 title: Text(element),
                                groupValue: selectedPetOption,onChanged: (String? e){  
                                  setState((){selectedPetOption = e!;});
                                },value: element,
                               )
                              ,)
                              ).toList()
                            ],
                           
                          );
                        }    
                      ),
                      const SizedBox(height: 10),
                      const Text("Porte"),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState)
                        {
                          return Row(
                            children: 
                            [ 
                              
                               ...sizeOptions.map<Widget>((element) => 
                               Flexible(
                                child: RadioListTile(
                                  
                                 title: Text(element),
                                groupValue: selectedSizeOption,onChanged: (String? e){  
                                  setState((){selectedSizeOption = e!;});
                                },value: element,
                               )
                              ,)
                              ).toList()
                            ],   
                          );
                        }    
                      ),
                      const SizedBox(height: 10),
                      const Text("Observações"),
                      const SizedBox(height: 10),
                      TextFormField(),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            onPressed: (){ 
                              final pet = Services().createPet(nome: nome.text, especie: selectedPetOption, porte: selectedSizeOption, dono: dono);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(dono: dono)));
                             },
                            style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.pink),
                            ),
                            child: const Text ('Cadastrar')
                          )
                      )
                    ]
                )
              )
            )
          )
        ),
      ),
      
    );
  }
}