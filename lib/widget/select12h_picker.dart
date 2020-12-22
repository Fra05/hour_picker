import 'package:flutter/material.dart';
import 'package:time_12h_picker/util/funciones.dart';

class Select12hPicker extends StatelessWidget {
  final FixedExtentScrollController minuteController;
  final FixedExtentScrollController typeController;
  final FixedExtentScrollController hourController;
  final Function onDone;

  Select12hPicker({
    Key key,
    @required this.minuteController,
    @required this.typeController,
    @required this.hourController,
    @required this.onDone,
  }) : super(key: key);

  List<_PickerModel> _listHour = [];

  List<_PickerModel> _listMinute = [
    _PickerModel(
      time: 0,
    ),
    _PickerModel(
      time: 30,
    ),
  ];

  List<_PickerModel> _listType = [
    _PickerModel(
      type: "A.M.",
    ),
    _PickerModel(
      type: "P.M.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_listHour.length == 0) {
      for (var i = 0; i < 12; i++) {
        _listHour.add(_PickerModel(time: i));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: onDone,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  "Aceptar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: 180,
              child: ListWheelScrollView(
                diameterRatio: 1,
                controller: hourController,
                physics: FixedExtentScrollPhysics(),
                children: _listHour.map((hour) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          dateFormat.format(hour.time == 00 ? 12 : hour.time),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                    ],
                  );
                }).toList(),
                itemExtent: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                ":",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: 180,
              child: ListWheelScrollView(
                diameterRatio: 1,
                controller: minuteController,
                physics: FixedExtentScrollPhysics(),
                children: _listMinute.map((minute) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          dateFormat.format(minute.time),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                    ],
                  );
                }).toList(),
                itemExtent: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                ":",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: 180,
              child: ListWheelScrollView(
                diameterRatio: 1,
                controller: typeController,
                physics: FixedExtentScrollPhysics(),
                children: _listType.map((type) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          type.type,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                    ],
                  );
                }).toList(),
                itemExtent: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PickerModel {
  final String type;
  final int time;

  _PickerModel({
    this.type,
    this.time,
  });
}
