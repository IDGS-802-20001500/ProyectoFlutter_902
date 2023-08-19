import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_902/admin_pages/add_productos.dart';
import 'package:proyecto_902/admin_pages/edit_productos.dart';
import 'package:proyecto_902/pages/admin_page.dart';
import 'package:proyecto_902/pages/login_page.dart';
import 'package:proyecto_902/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_902/pages/users_page.dart';
import 'package:proyecto_902/providers/perfil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(ChangeNotifierProvider(
    create: (context) => PerfilProvider(),
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gamer Galaxy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const LoginPage(),
        '/registrar':(context) => const RegisterPage(),
        '/cliente_home':(context) => const UserPages(),
        '/admin_home':(context) => AdminPage(),
        '/addProducto':(context) => const AddProducto(),
        '/editProducto':(context) => const EditProducto(),
      },

    );
  }
}

