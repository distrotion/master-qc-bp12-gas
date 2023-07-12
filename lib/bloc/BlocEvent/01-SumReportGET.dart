import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csv/csv.dart';
import '../../data/dummudata.dart';
import '../../model/model.dart';

//-------------------------------------------------

DateTime selectedDate = DateTime.now();

abstract class SumReportGET_Event {}

class SumReportGET_GET extends SumReportGET_Event {}

class SumReportGET_flush extends SumReportGET_Event {}

class SumReportGET_Bloc extends Bloc<SumReportGET_Event, String> {
  SumReportGET_Bloc() : super('') {
    on<SumReportGET_GET>((event, emit) {
      return _SumReportGET_GET('', emit);
    });
    on<SumReportGET_flush>((event, emit) {
      return _SumReportGET_flush('', emit);
    });
  }
  Future<void> _SumReportGET_GET(String toAdd, Emitter<String> emit) async {
    List<reportCSV> data = [];

    var input = dummydata;
    List<String> dataname = ['PO', 'LOT'];
    List<List<String>> datacsv = [];

    List<dynamic> row = [];
    print(input.length);
    if (input.isNotEmpty) {
      var itemlist = input[0]['itemlist'];
      // print(itemlist.length);
      //------------------------------------------------------NAME

      for (var j = 0; j < itemlist.length; j++) {
        if (input[0][itemlist[j].toString()] != null) {
          if (input[0][itemlist[j].toString()]['RESULTFORMAT'].toString() ==
              'Number') {
            for (var k = 0;
                k < input[0][itemlist[j].toString()]['data'].length;
                k++) {
              int num = 1;
              for (var v = 0;
                  v < input[0][itemlist[j].toString()]['data'][k].length;
                  v++) {
                if (v !=
                    input[0][itemlist[j].toString()]['data'][k].length - 1) {
                  dataname.add(
                      '${input[0][itemlist[j].toString()]['name']}(PIC${k + 1}-POINT${num})');
                } else {
                  dataname.add(
                      '${input[0][itemlist[j].toString()]['name']}(PIC${k + 1}-MEAN)');
                }

                num++;
              }
            }
            dataname
                .add('${input[0][itemlist[j].toString()]['name']}(ALL-MEAN)');
          }
          if (input[0][itemlist[j].toString()]['RESULTFORMAT'].toString() ==
              'Graph') {
            dataname.add('${input[0][itemlist[j].toString()]['name']}(X)');
            dataname.add('${input[0][itemlist[j].toString()]['name']}(Y)');
          }
        }
      }

      //------------------------------------------------------NAME
      //------------------------------------------------------data
      for (var i = 0; i < input.length; i++) {
        // List<String> datacsvin = [];
        List<String> datacsvin = [input[i]['PO'].toString(), ''];
        for (var j = 0; j < itemlist.length; j++) {
          if (input[i][itemlist[j].toString()] != null) {
            if (input[i][itemlist[j].toString()]['RESULTFORMAT'].toString() ==
                'Number') {
              for (var k = 0;
                  k < input[i][itemlist[j].toString()]['data'].length;
                  k++) {
                for (var v = 0;
                    v < input[i][itemlist[j].toString()]['data'][k].length;
                    v++) {
                  if (v !=
                      input[i][itemlist[j].toString()]['data'][k].length - 1) {
                    datacsvin.add(
                        '${input[i][itemlist[j].toString()]['data'][k][v]}');
                  } else {
                    datacsvin.add(
                        '${input[i][itemlist[j].toString()]['data'][k][v]}');
                  }
                }
              }
              datacsvin.add('${input[i][itemlist[j].toString()]['data_ans']}');
            } else if (input[i][itemlist[j].toString()]['RESULTFORMAT']
                    .toString() ==
                'Graph') {
              datacsvin
                  .add('${input[i][itemlist[j].toString()]['data_ans']['x']}');
              datacsvin
                  .add('${input[i][itemlist[j].toString()]['data_ans']['y']}');
            }
          }
        }
        // print(datacsvin.length);
        // print(dataname.length);
        if (datacsvin.length == dataname.length) {
          datacsv.add(datacsvin);
        }
      }

      print(datacsv);
      //------------------------------------------------------data

      //------------------------------------------------------make csv
      List<dynamic> row = [];
      List<List<dynamic>> rows = [];
      for (var s = 0; s < dataname.length; s++) {
        row.add(dataname[s]);
      }

      rows.add(row);

      for (var i = 0; i < datacsv.length; i++) {
        List<dynamic> rowin = [];
        for (var j = 0; j < datacsv[i].length; j++) {
          rowin.add(datacsv[i][j]);
        }
        rows.add(rowin);
      }

      String datetada = "${selectedDate.toLocal()}".split(' ')[0];
      String csv = const ListToCsvConverter().convert(rows);
      AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
        ..setAttribute("download", "test ${datetada}.csv")
        ..click();
      //------------------------------------------------------make csv
    }

    emit('');
  }

  Future<void> _SumReportGET_flush(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}

ExpCSV(List<reportCSV> data) {
  List<List<dynamic>> rows = [];

  for (int i = -1; i < data.length; i++) {
    List<dynamic> row = [];
    if (i == -1) {
      row.add('PO');
      row.add('CP');
      row.add('DATE');
      row.add('TPKLOT');
      row.add('CUSTNAME');
      row.add('CUSLOTNO');
      row.add('PART');
      row.add('PARTNAME');
      row.add('MATERIAL');
      row.add('QUANTITY');
      row.add('Appearance for Rust');
      row.add('Appearance for Black stain');
      row.add('Appearance for Contaminant');
      row.add('Water wet ability');
      row.add('Remain of CN on part');
      row.add('Surface Hardness');
      row.add('Surface Hardness');
      row.add('Surface Hardness');
      row.add('Surface Roughness');
      row.add('Surface Roughness');
      row.add('Surface Roughness');
      row.add('Compound Layer');
      row.add('Compound Layer');
      row.add('Compound Layer');
      row.add('Porous Thickness');
      row.add('Porous Thickness');
      row.add('Porous Thickness');

      //F73
    } else {
      row.add(data[i].PO);
      row.add(data[i].CP);
      row.add(data[i].F21);
      row.add(data[i].F28);
      row.add(data[i].F22);
      row.add(data[i].F23);
      row.add(data[i].F24);
      row.add(data[i].F25);
      row.add(data[i].F26);
      row.add(data[i].F27);
      row.add(data[i].F01);
      row.add(data[i].F02);
      row.add(data[i].F03);
      row.add(data[i].F04);
      row.add(data[i].F05);
      row.add(data[i].F09);
      row.add(data[i].F10);
      row.add(data[i].F11);
      row.add(data[i].F06);
      row.add(data[i].F07);
      row.add(data[i].F08);
      //
      row.add(data[i].F12);
      row.add(data[i].F13);
      row.add(data[i].F14);
      row.add(data[i].F15);
      row.add(data[i].F16);
      row.add(data[i].F17);
    }

    rows.add(row);
  }
  String datetada = "${selectedDate.toLocal()}".split(' ')[0];
  String csv = const ListToCsvConverter().convert(rows);
  AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
    ..setAttribute("download", "test ${datetada}.csv")
    ..click();
}
