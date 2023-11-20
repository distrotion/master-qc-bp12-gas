import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/01-SumReportGET.dart';
import 'P01SumReport/P01SumReportmain.dart';

//---------------------------------------------------------

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page1BlocTableBody();
  }
}

class Page1BlocTableBody extends StatelessWidget {
  const Page1BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SumReportGET_Bloc(),
        child: BlocBuilder<SumReportGET_Bloc, datauoutraw>(
          builder: (context, datain) {
            return Page1Body(
              datain: datain,
            );
          },
        ));
  }
}

class Page1Body extends StatelessWidget {
  Page1Body({
    Key? key,
    this.datain,
  }) : super(key: key);
  datauoutraw? datain = datauoutraw();

  @override
  Widget build(BuildContext context) {
    return P01SumReportmain(
      datain: datain,
    );
  }
}
