import 'package:flutter/material.dart';
import 'package:proyecto_902/services/services.dart';

class ProductosAdmin extends StatefulWidget {
  const ProductosAdmin({super.key});

  @override
  State<ProductosAdmin> createState() => _ProductosAdminState();
}

class _ProductosAdminState extends State<ProductosAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductos(context),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ReorderableListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data?[index]['uid']),
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text('Eliminar', style: TextStyle(fontSize: 14, color: Colors.white),),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        
                      ],
                    )
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction)async {
                    await deleteProducto(context,snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async{

                    bool result = false;

                    result = await showDialog(context: context, builder: (context) {

                      return AlertDialog(
                        title: Text("¿Está seguro de eliminar a ${snapshot.data?[index]['nombre']}?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context, false);
                            }, 
                            child: const Text('No', style: TextStyle(color: Colors.red),)
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context, true);
                            }, 
                            child: const Text('Si')
                          ),
                        ],
                      );

                    });

                    return result;
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.purple[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Ajusta el valor según tu preferencia
                    ),
                    key: ValueKey(index), // Asigna una clave única al Card
                    child: ListTile(
                      title: Text(snapshot.data?[index]['nombre']),
                      subtitle: Text('\$' +
                        snapshot.data?[index]['precio']
                      ),
                      trailing: Wrap (
                        spacing: 5,
                        children: [
                        IconButton(
                          onPressed: () async {
                            await Navigator.pushNamed(context, "/editProducto", arguments: {
                              "nombre": snapshot.data?[index]['nombre'],
                              "precio": snapshot.data?[index]['precio'],
                              "uid": snapshot.data?[index]['uid'],
                              "descripcion": snapshot.data?[index]['descripcion'],
                              "anio": snapshot.data?[index]['anio'],
                            });
                            setState(() {
                              
                            });
                          },
                          icon: Icon(Icons.edit),
                          splashRadius: 20),
                        ],
                      ),
                    ),
                  )
                );
              },
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = snapshot.data?[oldIndex];
                  snapshot.data?.removeAt(oldIndex);
                  snapshot.data?.insert(newIndex, item);
                });
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.pushNamed(context, '/addProducto');
          setState(() {
            
          });
        }, 
        child: const Icon(Icons.add),
      ),
    );
  }
}
