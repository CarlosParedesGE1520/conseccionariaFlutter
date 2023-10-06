import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Almacenes extends StatefulWidget {
  final String nombre;

  const Almacenes({
    super.key,
    required this.nombre,
  });

  @override
  State<Almacenes> createState() => _AlmacenesState();
}

class _AlmacenesState extends State<Almacenes> {
  Future<List<dynamic>> getData(String local) async {
    Dio dio = Dio();

    var response = await dio
        .get('http://192.168.74.29:8080/conseccionario/listAlmacenes/$local');
    //print(response.data.toString());

    return response.data;
  }

  Future<Map<String, dynamic>> postData(Map<String, dynamic> nuevaVenta) async {
    print('fghfgds');
    print(nuevaVenta);
    Dio dio = Dio();

    var response = await dio
        .post('http://192.168.74.29:8080/conseccionario/add', data: nuevaVenta);
    //print(response.data.toString());

    return response.data;
  }

  int cantidad = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lista Almacen  ')),
        body: FutureBuilder<List<dynamic>>(
            future: getData(widget.nombre),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, i) => Divider(
                          color: Colors.blue,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            Text('${snapshot.data?[index]['conNomAlmacen']}'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: AlertDialog(
                                  contentPadding: EdgeInsets.all(16.0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Consecionario ${widget.nombre}'),
                                      Text(
                                          'Local ${snapshot.data?[index]['conNomAlmacen']}'),
                                      Text('Consecionario ${widget.nombre}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FilledButton(
                                              onPressed: () {
                                                final Map<String, dynamic>
                                                    nuevaVenta = {
                                                  "conFechaVenta":
                                                      DateTime.now()
                                                          .toIso8601String(),
                                                  "conNomEmpresa":
                                                      snapshot.data?[index]
                                                          ['conNomAlmacen'],
                                                  "conNomAlmacen":
                                                      widget.nombre,
                                                  "conCantidad": 1,
                                                  "conTipoFactura": "FACTURA"
                                                };

                                                postData(nuevaVenta)
                                                    .then((value) {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('Nueva venta')),
                                          SizedBox(width: 20),
                                          FilledButton(
                                              onPressed: () {
                                                final Map<String, dynamic>
                                                    nuevaVenta = {
                                                  "conFechaVenta":
                                                      DateTime.now()
                                                          .toIso8601String(),
                                                  "conNomEmpresa":
                                                      snapshot.data?[index]
                                                          ['conNomAlmacen'],
                                                  "conNomAlmacen":
                                                      widget.nombre,
                                                  "conCantidad": -1,
                                                  "conTipoFactura": "FACTURA"
                                                };
                                                //print(nuevaVenta);
                                                postData(nuevaVenta)
                                                    .then((value) {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text('Devolverver'))
                                        ],
                                      ),
                                    ],
                                  ),
                                  // actions: [],
                                ),
                              );
                            },
                          );
                        },

                        // Agrega más widgets aquí para personalizar la apariencia de cada elemento
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
                //return Text('No jhay');
              }
            }));
  }
}
