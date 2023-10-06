import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//DatosConseccion    http://192.168.18.43:8080/conseccionario/listcantidad'

class ReporteConseccionaria extends StatelessWidget {
  const ReporteConseccionaria({super.key});

  Future<List<dynamic>> getData() async {
    Dio dio = Dio();

    var response =
        await dio.get('http://192.168.74.29:8080/conseccionario/listcantidad');
    print(response.data.toString());

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reporte de ventas Concessionarias')),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            // Crear una lista de DataColumn para las columnas de la tabla
            List<DataColumn> columns = [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Cantidad')),
            ];

            // Crear una lista de DataRow para los datos de la tabla
            List<DataRow> rows = [];

            for (var data in snapshot.data!) {
              rows.add(DataRow(
                cells: [
                  DataCell(Text('${data['con_nom_empresa']}')),
                  DataCell(Text('${data['con_cantidad']}')),
                ],
              ));
            }

            // Crear la DataTable con las columnas y las filas
            return SingleChildScrollView(
              scrollDirection: Axis.vertical, // Desplazamiento vertical
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                child: DataTable(
                  columns: columns,
                  rows: rows,
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
