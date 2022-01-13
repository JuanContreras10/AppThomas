import 'package:flutter/material.dart';
import 'package:thomas/src/pages/vistaDetallesSecuencia.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    // '/': (BuildContext context) => PanelCentral(),
    'vistaDetallesSecuencia': (BuildContext context) =>
        DetallesSecuencia(title: 'app', autor: 'Thomas', lista: []),
  };
}
