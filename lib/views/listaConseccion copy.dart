import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListaConseccionaria extends StatelessWidget {
  const ListaConseccionaria({super.key});

  Future<List<dynamic>> getData() async {
    Dio dio = Dio();

    var response =
        await dio.get('http://192.168.74.29:8080/conseccionario/list');
    print(response.data.toString());

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Concessionarias')),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            // Crear una lista de DataColumn para las columnas de la tabla
            List<DataColumn> columns = [
              DataColumn(
                label: Text('Nombre'),
                tooltip: 'Nombre',
                onSort: (columnIndex, ascending) {
                  // Lógica de ordenamiento si es necesario
                },
                numeric: false, // No es una columna numérica
                // Establecer un ancho específico para la columna "Nombre"
                // Cambia el valor de width según tus necesidades
                // Ejemplo: width: 150,
              ),
              DataColumn(
                label: Text('Almacen'),
                tooltip: 'Almacen',
                onSort: (columnIndex, ascending) {
                  // Lógica de ordenamiento si es necesario
                },
                numeric: false, // No es una columna numérica
                // Establecer un ancho específico para la columna "Almacen"
                // Cambia el valor de width según tus necesidades
                // Ejemplo: width: 100,
              ),
              DataColumn(
                label: Text('Cantidad'),
                tooltip: 'Cantidad',
                onSort: (columnIndex, ascending) {
                  // Lógica de ordenamiento si es necesario
                },
                numeric: true, // Es una columna numérica
                // Establecer un ancho específico para la columna "Cantidad"
                // Cambia el valor de width según tus necesidades
                // Ejemplo: width: 80,
              ),
              DataColumn(
                label: Text('Fecha'),
                tooltip: 'Fecha',
                onSort: (columnIndex, ascending) {
                  // Lógica de ordenamiento si es necesario
                },
                numeric: false, // No es una columna numérica
                // Establecer un ancho específico para la columna "Fecha"
                // Cambia el valor de width según tus necesidades
                // Ejemplo: width: 120,
              ),
            ];

            // Crear una lista de DataRow para los datos de la tabla
            List<DataRow> rows = [];

            for (var data in snapshot.data!) {
              rows.add(DataRow(
                cells: [
                  DataCell(Text('${data['conNomEmpresa']}')),
                  DataCell(Text('${data['conNomAlmacen']}')),
                  DataCell(Text('${data['conCantidad']}')),
                  DataCell(Text('${data['conFechaVenta']}')),
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
