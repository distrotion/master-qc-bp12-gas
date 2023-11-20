import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/global.dart';
import '../../widget/common/Safty.dart';

String server = 'http://127.0.0.1:15000/';
// String server = serverGB;

class LineGraphSoi8_Cubit extends Cubit<LineGraphSoi8> {
  /// {@macro brightness_cubit}
  LineGraphSoi8_Cubit() : super(LineGraphSoi8());

  /// Toggles the current brightness between light and dark.
  Future<void> LineGraphSoi8Get(
      String MATCP, String plant, String methode) async {
    LineGraphSoi8 output = LineGraphSoi8();
    final service = await Dio().post(
      server + "getallgraph",
      data: {
        "MATCP": MATCP,
        "plant": plant,
      },
    );

    if (service.statusCode == 200) {
      var databuff = service.data;
      print(databuff);

      if (databuff != null) {
        List<FlSpot> upperout = [];
        List<FlSpot> dataout = [];
        List<FlSpot> lowerout = [];
        Map<String, String> datedataout = {};
        String NAME = '';

        for (int i = 0; i < databuff['outdata'].length; i++) {
          if (databuff['outdata'][i][methode] != null) {
            if (i == 0) {
              NAME = databuff['outdata'][i]['ProductName'] ?? '';
            }

            // print(databuff['outdata'][i][methode]);
            if (databuff['outdata'][i][methode]['T1Stc'] != null) {
              double data = 0;
              double upper = 0;
              double lower = 0;
              if (databuff['outdata'][i][methode]['T1Stc'].toString() ==
                  'lightgreen') {
                data = double.parse(ConverstStr(
                    databuff['outdata'][i][methode]['T1'].toString()));
              }
              if (databuff['outdata'][i][methode]['T2Stc'].toString() ==
                  'lightgreen') {
                data = double.parse(ConverstStr(
                    databuff['outdata'][i][methode]['T2'].toString()));
              }
              if (databuff['outdata'][i][methode]['T3Stc'].toString() ==
                  'lightgreen') {
                data = double.parse(ConverstStr(
                    databuff['outdata'][i][methode]['T3'].toString()));
              }

              if (data != 0) {
                // print(i.toDouble());
                // print(data);
                dataout.add(FlSpot(i.toDouble(), data));
                upper = double.parse(ConverstStr(
                    databuff['outdata'][i][methode]['SPEC']['HI'].toString()));
                lower = double.parse(ConverstStr(
                    databuff['outdata'][i][methode]['SPEC']['LOW'].toString()));

                upperout.add(FlSpot(i.toDouble(), upper));
                lowerout.add(FlSpot(i.toDouble(), lower));

                if (databuff['outdata'][i]['_id'] != null) {
                  datedataout[
                      (i.toDouble())
                          .toString()] = '${databuff['outdata'][i]['PO']}  ' +
                      '(${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(databuff['outdata'][i]['_id'].toString().substring(0, 8), radix: 16) * 1000))})';
                } else {
                  datedataout[(i.toDouble()).toString()] = "";
                }
              } else {
                if (databuff['outdata'][i]['_id'] != null) {
                  datedataout[
                      (i.toDouble())
                          .toString()] = '${databuff['outdata'][i]['PO']}  ' +
                      '(${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(databuff['outdata'][i]['_id'].toString().substring(0, 8), radix: 16) * 1000))})';
                } else {
                  datedataout[(i.toDouble()).toString()] = "";
                }
              }
            }
          }
        }

        // print(datedataout);

        output.upper = upperout;

        output.data = dataout;

        output.lower = lowerout;

        output.datedata = datedataout;

        output.PRODUCTNAME = NAME;
      }
    }
    emit(output); //ConverstStr
  }

  Future<void> LineGraphSoi8Flush(String input) async {
    LineGraphSoi8 output = LineGraphSoi8();
    emit(output);
  }
}

class LineGraphSoi8 {
  LineGraphSoi8({
    this.PLANT = '',
    this.upper = const [],
    this.data = const [],
    this.lower = const [],
    this.datedata = const {},
    this.PRODUCTNAME = '',
  });
  String PLANT;
  List<FlSpot> upper;
  List<FlSpot> data;
  List<FlSpot> lower;
  Map<String, String> datedata;
  String PRODUCTNAME;
}

int hexstr(String fullString) {
  int number = 0;
  for (int i = 0; i <= fullString.length - 8; i += 8) {
    final hex = fullString.substring(i, i + 8);

    number = int.parse(hex, radix: 16);
  }

  return number;
}
