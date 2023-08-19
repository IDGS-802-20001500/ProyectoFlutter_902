import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/providers/perfil.dart';
import 'dart:math';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Registrar usuario

Future<void> registrarUsuario(
    String usuario, String correo, String contra, context) async {
  try {
    await db.collection('usuarios').add({
      'usuario': usuario,
      'correo': correo,
      'password': contra,
      'role': 'cliente',
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Bienvenido ${usuario}, ahora puedes iniciar sesión',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  } catch (error) {
    print('Error al registrar usuario: $error');
  }
}

// Iniciar sesión

Future<void> LogOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> login(String email, String password, context) async {
  try {
    QuerySnapshot queryCorreo =
      await db.collection('usuarios').where('correo', isEqualTo: email).get();

    if (queryCorreo.docs.isNotEmpty) {
      QuerySnapshot queryPassword = await db
          .collection('usuarios')
          .where('password', isEqualTo: password)
          .get();

      if (queryPassword.docs.isNotEmpty) {

        String role = queryCorreo.docs[0]['role'];
        String usuario = queryCorreo.docs[0]['usuario'];
        String correo = queryCorreo.docs[0]['correo'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('usuario', usuario);
        await prefs.setString('correo', correo);

        final perfilProvider = Provider.of<PerfilProvider>(context, listen: false);

        perfilProvider.setNombre(prefs.getString('usuario')!);
        perfilProvider.setCorreo(prefs.getString('correo')!);

        // Redirigir según el rol del usuario
        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin_home');
        } else if (role == 'cliente') {
          Navigator.pushReplacementNamed(context, '/cliente_home');
        } else {
          print('WTF?');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error, verifica tus datos',
            style: TextStyle(fontSize: 18),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error, verifica tus datos',
          style: TextStyle(fontSize: 18),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    }
  } catch (error) {
    print('Error al iniciar sesión: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error al iniciar sesión, verifica tus datos',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }
}


Future<List> getUsuarios() async {
  List usuarios = [];
  try {
    QuerySnapshot query = await db.collection('usuarios').get();

    for (var doc in query.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      final users = {
        'uid': doc.id,
        'usuario': data['usuario'],
        'correo': data['correo'],
        'role': data['role'],
        'password': data['password'],
      };

      usuarios.add(users);
    }
  } catch (error) {
    print('Error al obtener usuarios: $error');
  }


  await Future.delayed(const Duration(seconds: 2),);

  return usuarios;
}



Future<List> getProductos(context) async {
  List productos = [];
  try {
    QuerySnapshot query = await db.collection('productos').get();

    for (var doc in query.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      final product = {
        'uid': doc.id,
        'nombre': data['nombre'],
        'precio': data['precio'],
        'imagen': data['imagen'],
        'descripcion': data['descripcion'],
        'anio': data['anio'],
      };

      productos.add(product);
    }
  } catch (error) {
    print('Error al obtener productos: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }


  await Future.delayed(const Duration(seconds: 2),);

  return productos;
}

Future<void> addProducto(context,String nombre, String desc, String precio, String anio) async {

  try{
    await db.collection('productos').add({
      'nombre': nombre,
      'precio': precio,
      'imagen': 'xd',
      'descripcion': desc,
      'anio': anio,
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Se agrego un nuevo juego',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));



  }catch(error){
    print('Error al agregar producto: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Error al agregar producto, verifica tus datos',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }
}

Future<void> updateProducto(String uid, String newNombre, String newDesc, String newPrecio, String newAnio) async {
  try{
    await db.collection('productos').doc(uid).set({"nombre": newNombre, "descripcion": newDesc, "precio": newPrecio, "anio": newAnio, "imagen": "xd"});

  }catch(error){
    print('Error al actualizar producto: $error');
  }
}

Future<void> deleteProducto(context, String uid) async {
  try{
    await db.collection('productos').doc(uid).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Se elimino correctamente',
        style: TextStyle(fontSize: 18),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
    
  }catch(error){
    print('Error al eliminar producto: $error');
  }
}

// Future<XFile?> getImagen() async {
//   final ImagePicker picker = ImagePicker();
//   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//   return image;
// }
