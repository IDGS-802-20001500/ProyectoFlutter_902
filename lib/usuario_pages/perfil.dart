import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/providers/perfil.dart';

class PerfilUser extends StatefulWidget {
  const PerfilUser({super.key});

  @override
  State<PerfilUser> createState() => _PerfilUserState();
}

class _PerfilUserState extends State<PerfilUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Icon(Icons.person, size: 200, color: Colors.grey,),
            ),
            SizedBox(height: 20,),
            Container(
              child: Text('Nombre de usuario: ${context.watch<PerfilProvider>().nombre}', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 20,),
            Container(
              child: Text('Correo: ${context.watch<PerfilProvider>().correo}', style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}