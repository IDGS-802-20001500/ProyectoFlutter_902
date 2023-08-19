import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilProvider extends ChangeNotifier{

  String _nombre = '';
  String _correo = '';

  String get nombre => _nombre;
  String get correo => _correo;

  Future<void> cargarDatosDesdeSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nombre = prefs.getString('usuario') ?? '';
    _correo = prefs.getString('correo') ?? '';
    notifyListeners();
  }
  

  void setNombre(String nombre) async {
    _nombre = nombre;
    notifyListeners();
  }

  void setCorreo(String correo) async {
    _correo = correo;
    notifyListeners();
  }

}