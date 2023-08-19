import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/admin_pages/admin_home.dart';
import 'package:proyecto_902/admin_pages/user_catalog.dart';
import 'package:proyecto_902/providers/perfil.dart';
import 'package:proyecto_902/services/services.dart';

import '../admin_pages/productos_catalog.dart';


class AdminPage extends StatefulWidget {
  AdminPage({super.key});


  

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[

    const AdminHomePage(),
    const ProductosAdmin(),
    const UserCatalog(),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administracción'),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
        ],
      ),
    );
  }
}