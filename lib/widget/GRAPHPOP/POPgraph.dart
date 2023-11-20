import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Cubit/GRAPHPOP-LineGraphSoi8.dart';
import 'LineGraphSoi8.dart';

void LineGraphPOP(
  BuildContext contextin,
) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: LineGraphSoi8Widget(),
      );
    },
  );
}

class LineGraphSoi8Widget extends StatefulWidget {
  LineGraphSoi8Widget({
    super.key,
  });

  @override
  State<LineGraphSoi8Widget> createState() => _LineGraphSoi8WidgetState();
}

class _LineGraphSoi8WidgetState extends State<LineGraphSoi8Widget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<LineGraphSoi8_Cubit>().LineGraphSoi8Get(
    //     widget.MATCP ?? '', widget.plant ?? '', widget.methode ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      width: 800,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 800,
              child: Center(
                child: Text(
                  '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              // height: 500,
              width: 800,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ControlChartSoi8(
                    // upper: widget.data?.upper ?? [],
                    // data: widget.data?.data ?? [],
                    // under: widget.data?.lower ?? [],
                    // datedata: widget.data?.datedata ?? {},
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlldataPOP {
  AlldataPOP({
    this.NAME = '',
    this.MATCP = '',
  });
  String NAME;
  String MATCP;
}
