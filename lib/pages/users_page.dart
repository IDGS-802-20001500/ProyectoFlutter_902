import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/providers/perfil.dart';
import 'package:proyecto_902/services/services.dart';
import 'package:proyecto_902/usuario_pages/perfil.dart';
import 'package:proyecto_902/usuario_pages/product_catalog_user.dart';
import 'package:proyecto_902/usuario_pages/user_home.dart';



class UserPages extends StatefulWidget {
  const UserPages({super.key});

  @override
  State<UserPages> createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {


  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[

    const UserHome(),
    const ProductCatalog(),
    const PerfilUser(),

  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gamer Galaxy'),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              Text(
                context.watch<PerfilProvider>().nombre,
              ),
              IconButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/');
                  LogOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Juegos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}