import 'dart:convert';

List<Consecciones> conseccionesFromMap(String str) => List<Consecciones>.from(
    json.decode(str).map((x) => Consecciones.fromMap(x)));

String conseccionesToMap(List<Consecciones> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Consecciones {
  int id;
  String conFechaVenta;
  String conNomEmpresa;
  String conNomAlmacen;
  int conCantidad;
  String conNomTipoFactura;

  Consecciones({
    this.id = 0,
    this.conFechaVenta = '',
    this.conNomEmpresa = '',
    this.conNomAlmacen = '',
    this.conCantidad = 3,
    this.conNomTipoFactura = '',
  });

  factory Consecciones.fromMap(Map<String, dynamic> json) => Consecciones(
        id: json["id"] != null ? json["id"] as int : 0,
        conFechaVenta: json["con_fecha_venta"] != null
            ? json["con_fecha_venta"] as String
            : '',
        conNomEmpresa: json["con_nom_empresa"] != null
            ? json["con_nom_empresa"] as String
            : '',
        conNomAlmacen: json["con_nom_almacen"] != null
            ? json["con_nom_almacen"] as String
            : '',
        conCantidad:
            json["con_cantidad"] != null ? json["con_cantidad"] as int : 0,
        conNomTipoFactura: json["con_nom_tipo_factura"] != null
            ? json["con_nom_tipo_factura"] as String
            : '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "con_fecha_venta": conFechaVenta,
        "con_nom_empresa": conNomEmpresa,
        "con_nom_almacen": conNomAlmacen,
        "con_cantidad": conCantidad,
        "con_nom_tipo_factura": conNomTipoFactura,
      };
}
