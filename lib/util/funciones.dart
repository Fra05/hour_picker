import 'package:intl/intl.dart';

String convetirFecha(String fecha) {
  final sp = fecha.split("/");
  final formatoFecha =
      "${sp[2].toString()}-${sp[1].toString()}-${sp[0].toString()}";

  return formatoFecha;
}

NumberFormat dateFormat = NumberFormat('00');
