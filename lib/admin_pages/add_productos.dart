import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_902/services/services.dart';

class AddProducto extends StatefulWidget {
  const AddProducto({super.key});

  @override
  State<AddProducto> createState() => _AddProductoState();
}

class _AddProductoState extends State<AddProducto> {


  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController anioController = TextEditingController();
  

  void regresarPantallaProductos(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/admin_home'));
  }

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                regresarPantallaProductos(context);
              },
              child: Text('Regresar'),
            ),

            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                labelText: 'Nombre del producto',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                labelText: 'Descripción',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                labelText: 'Precio',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: anioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                labelText: 'Año del juego',
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async{
                await addProducto(
                  context,
                  nombreController.text,
                  descripcionController.text,
                  precioController.text,
                  anioController.text,
                ).then((_) {
                  regresarPantallaProductos(context);
               });
              }, 
              child: const Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
