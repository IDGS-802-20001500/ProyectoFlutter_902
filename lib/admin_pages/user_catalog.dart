import 'package:flutter/material.dart';
import 'package:proyecto_902/services/services.dart';

class UserCatalog extends StatefulWidget {
  const UserCatalog({super.key});

  @override
  State<UserCatalog> createState() => _UserCatalogState();
}

class _UserCatalogState extends State<UserCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUsuarios(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.lime[100],
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Ajusta el valor según tu preferencia
                  ),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['usuario']),
                    subtitle: Text(snapshot.data?[index]['correo']),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
