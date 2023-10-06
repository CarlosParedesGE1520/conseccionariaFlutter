import 'package:app_spring/views/gestion_conseccionaria_lista.dart';
import 'package:app_spring/views/listaConseccion%20copy.dart';
import 'package:app_spring/views/reporteConseccion.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Conseccionaria'),
          //backgroundColor: appTheme.,
        ),
        drawer: _MenuPrincipal(),
        body: Row(
          children: <Widget>[
            Container(
              width: 300,
              height: double.infinity,
            ),
          ],
        ));
  }
}

class _ListaOpciones extends StatelessWidget {
  const _ListaOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      "Gestion conseccionarios",
      "Reporte conseccionarios",
      "Listar Conseccionarios ",
    ];
    return ListView.separated(
      padding: EdgeInsets.only(right: 10, left: 10),
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, i) => Divider(
        color: Colors.blue,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(color: Color.fromARGB(255, 221, 221, 221)),
          child: ListTile(
            title: Text(options[index]),
            onTap: () {
              if (index == 0) {
                print("Opción 1 seleccionada");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GestionConseccionarias()));
              } else if (index == 1) {
                print("Opción 2 seleccionada");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReporteConseccionaria()));
              } else if (index == 2) {
                print("Opción 3 seleccionada");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListaConseccionaria()));
              }
            },
          ),
        );
      },
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 100),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 50, color: Colors.amber),
                  ),
                ),
              ),
            ),
            Expanded(child: _ListaOpciones()),
          ],
        ),
      ),
    );
  }
}
