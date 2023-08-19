import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/providers/perfil.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {


  


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