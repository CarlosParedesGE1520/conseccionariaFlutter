// final response = await Dio()
//     .get('http://192.168.18.43:8080/conseccionario/listConseccionarias');

import 'package:app_spring/views/AlmacenesView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GestionConseccionarias extends StatelessWidget {
  const GestionConseccionarias({super.key});

  Future<List<dynamic>> getData() async {
    Dio dio = Dio();

    var response = await dio
        .get('http://192.168.74.29:8080/conseccionario/listConseccionarias');
    //print(response.data.toString());

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Concessionarias')),
        body: FutureBuilder<List<dynamic>>(
            future: getData(),
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
                        title: Text('${snapshot.data?[index]}'),
                        onTap: () {
                          print(snapshot.data?[index]);
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Almacenes(
                                          nombre: snapshot.data?[index])))
                              .then((newContact) {
                            if (newContact != null) {
                              // menssageResponse(
                              //     context, newContact.name + " a sido modificado");
                            }
                          });
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
