import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/providers/perfil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {


   


  @override
  Widget build(BuildContext context) {
    context.read<PerfilProvider>().cargarDatosDesdeSharedPrefs();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("Bienvenido \n " + context.watch<PerfilProvider>().nombre, style: TextStyle(fontSize: 32),),
            ),
          ],
        ),
      ),
      
    );
  }
}