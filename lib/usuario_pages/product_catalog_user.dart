import 'package:flutter/material.dart';
import 'package:proyecto_902/services/services.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductos(context),
        builder: ((context, snapshot) {
          if (snapshot.hasData){
              return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Ajusta el valor según tu preferencia
                  ),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['nombre']),
                    subtitle: Text('\$'+ (snapshot.data?[index]['precio'].toString() ?? '')),
                  ),
                );
              },
            );
          }
          else
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      
    );
  }
}