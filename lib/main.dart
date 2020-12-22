import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_12h_picker/util/funciones.dart';
import 'package:time_12h_picker/widget/select12h_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Intl.defaultLocale = 'es';
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HourPicker(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('es'),
    );
  }
}

class HourPicker extends StatefulWidget {
  @override
  _HourPickerState createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> with TickerProviderStateMixin {
  FixedExtentScrollController _hourController;
  FixedExtentScrollController _minuteController;
  FixedExtentScrollController _typeController;

  String hora = "Hora";

  String _selectedHour;
  String valueToValidate4 = '';
  String valueSaved4 = '';

  @override
  void initState() {
    _hourController = FixedExtentScrollController();
    _minuteController = FixedExtentScrollController();
    _typeController = FixedExtentScrollController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _hourController.dispose();
    _minuteController.dispose();
    _typeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedHour == null ? "$hora" : "$_selectedHour",
            ),
            RaisedButton(
              child: Text("Seleccionar"),
              onPressed: _selectHour,
            ),
          ],
        ),
      ),
    );
  }

  _selectHour() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Select12hPicker(
          hourController: _hourController,
          minuteController: _minuteController,
          typeController: _typeController,
          onDone: () {
            // print(
            //     "${_hourController.selectedItem == 00 ? 12 : _hourController.selectedItem}:${_minuteController.selectedItem == 0 ? '00' : '30'} ${_typeController.selectedItem != 0 ? 'P.M.' : 'A.M.'}");

            setState(() {
              _selectedHour =
                  "${_hourController.selectedItem == 0 ? 12 : dateFormat.format(_typeController.selectedItem != 0 ? _hourController.selectedItem + 12 : _hourController.selectedItem)}:${_minuteController.selectedItem == 0 ? '00' : '30'}";

              DateTime todayHour = DateTime.parse(
                  convetirFecha(DateFormat.yMd('pt').format(DateTime.now())) +
                      " " +
                      _selectedHour);

              _selectedHour = DateFormat('hh:mm a').format(todayHour);
              print("FECHA: " + DateFormat('hh:mm a').format(todayHour));
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
