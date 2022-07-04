import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/agendamento.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';
import '../core/extensions/string.dart';

class AgendamentoView extends StatefulWidget
{
  AgendamentoView({required this.dono});
  
  final DatabaseUser dono;

  @override
  State<AgendamentoView> createState() => _AgendamentoViewState();
}

class _AgendamentoViewState extends State<AgendamentoView> {
  List<DatabaseAgenda>? agenda;

  @override
  void initState() {
    super.initState();
    print(widget.dono.id);
    _getAgendas();
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
          itemCount: agenda?.length,
          itemBuilder: (context, index) => Card(
            
            color: Colors.pinkAccent,
            
            child: Padding( padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(agenda![index].servico.capitalize()),
                      Text(agenda![index].data.toString()),
                      FutureBuilder(
                        future: Services().getPetNamebyId(agenda![index].idPet),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting)
                          {
                            return CircularProgressIndicator();
                          }
                          if(snapshot.hasData == false){
                            return Text("Nome não encontrado");
                          }
                          return Text(snapshot.data.toString());
                        }
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoQRFGhTohxgMhL1y0UcYET18Z91LfGyMwpA&usqp=CAU", width: 70,),),
                        ElevatedButton(onPressed:(){
                          Services().deleteAgenda(id: agenda![index].id);
                        
                        }, child: Text("Excluir"),
                        style: ButtonStyle( backgroundColor:MaterialStateProperty.all<Color>(Colors.red),),)
                      ],
                    )),
                )
              ],
            ),
          )),
      ),
      )
    );
  }

  Future<void> _getAgendas() async {
    _setLoading(true);
    agenda = await Services().getAllAgenda(dono: widget.dono);
    _setLoading(false);
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }
}