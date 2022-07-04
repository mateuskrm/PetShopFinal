import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/agendamento.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';
import '../core/extensions/string.dart';

class PetView extends StatefulWidget
{
  PetView({required this.dono});
  
  final DatabaseUser dono;

  @override
  State<PetView> createState() => _PetViewState();
}

class _PetViewState extends State<PetView> {
  List<DatabasePet>? pets;

  @override
  void initState() {
    super.initState();
    _getPets();
  }

bool _loading = false;

  @override
  Widget build(BuildContext context) 
  { 

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Meu Petshop"),
        backgroundColor: Colors.pink
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: _loading ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: pets?.length,
          itemBuilder: (context, index) => Card(
            color: Colors.pinkAccent,
            child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pets![index].nome.capitalize()),
                      Text(pets![index].especie.capitalize()),
                      Text(pets![index].porte.capitalize()),
                      SizedBox(height: 15,),
                      ElevatedButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Agendamento(dono: widget.dono, pet: pets![index],)));
                      }, child: Text("Agendar"),
                       style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.pink),),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: 
                    Column(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoQRFGhTohxgMhL1y0UcYET18Z91LfGyMwpA&usqp=CAU", width: 70,),),
                        ElevatedButton(onPressed:(){
                          Services().deletePet(id: pets![index].id);
                        
                      }, child: Text("Excluir"),
                       style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.red),),)
                      ],
                    ))
                
                
                )
              
              ],
            ),
          )
          )
        ),
        )
      );
  }

  Future<void> _getPets() async {
    _setLoading(true);
    pets = await Services().getAllPets(dono: widget.dono);
    _setLoading(false);
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }
}
