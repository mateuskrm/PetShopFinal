import 'package:flutter/material.dart';
import 'package:projeto_pet_shop/presenters/agendamento.dart';
import 'package:projeto_pet_shop/presenters/agendamento_view.dart';
import 'package:projeto_pet_shop/presenters/cadastro_animal.dart';
import 'package:projeto_pet_shop/presenters/home.dart';
import 'package:projeto_pet_shop/presenters/pet_view.dart';
import 'package:projeto_pet_shop/presenters/settings.dart';
import 'package:projeto_pet_shop/services/crud/nodes_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.dono}) : super(key: key);

  final DatabaseUser dono;

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late Widget screen;
  int screenIndex = 1;

  @override
  void initState() {
    super.initState();
    screen = PetView(dono: widget.dono);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.pinkAccent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            screenIndex = index;
            switch (index) {
              case 0:
                setPage(Home(dono: widget.dono));
                break;
              case 1:
                setPage(PetView(dono: widget.dono));
                break;
              case 2:
                setPage(CadastroAnimal(dono: widget.dono,));
                break;
              case 3:
                setPage(AgendamentoView(dono: widget.dono));
                break;
              case 4:
                setPage(Settings());
                break;
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.pinkAccent,
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Pets",
              icon: Icon(Icons.pets),
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Adicionar",
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Agendamentos",
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Configurações",
              backgroundColor: Colors.pinkAccent,
            ),
          ],
        ));
  }

  void setPage(Widget page) {
    setState(() {
      screen = page;
    });
  }
}
