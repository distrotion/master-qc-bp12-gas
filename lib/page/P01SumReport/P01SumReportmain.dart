import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/01-SumReportGET.dart';

class P01SumReportmain extends StatelessWidget {
  const P01SumReportmain({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          //
          context.read<SumReportGET_Bloc>().add(SumReportGET_GET());
        },
        child: Container(
          width: 100,
          height: 40,
          color: Colors.red,
        ),
      ),
    );
  }
}
