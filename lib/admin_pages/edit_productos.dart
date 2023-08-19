import 'package:flutter/material.dart';
import 'package:proyecto_902/services/services.dart';

class EditProducto extends StatefulWidget {
  const EditProducto({super.key});

  @override
  State<EditProducto> createState() => _EditProductoState();
}

class _EditProductoState extends State<EditProducto> {




  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController anioController = TextEditingController();

  void regresarPantallaProductos(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/admin_home'));
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    nombreController.text = arguments['nombre'];
    precioController.text = arguments['precio'];
    descripcionController.text = arguments['descripcion'];
    anioController.text = arguments['anio'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
      ),
      body: Center(
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
                border: OutlineInputBorder(),
                labelText: 'Nombre del producto',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descripción',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: anioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Año del juego',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await updateProducto(
                  arguments['uid'],
                  nombreController.text,
                  descripcionController.text,
                  precioController.text,
                  anioController.text,
                ).then((_) {
                  regresarPantallaProductos(context);
                });
              },
              child: const Text('Actualizar'),
            )
          ],
        ),
      ),
    );
  }
}
