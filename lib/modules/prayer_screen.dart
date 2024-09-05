import 'package:daily_supplications_app/shared/cubit/cubit.dart';
import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'supplications_screen.dart';

class PrayerScreen extends StatelessWidget {
  String? title;
  int? number;
  int? id;

  PrayerScreen(this.title, this.number,this.id);

  @override
  Widget build(BuildContext context) {
    double num = double.parse(number.toString());
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
AppCubit.get(context).number=0;
Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplicationsScreen()));
            }, icon: Icon(Icons.arrow_back),),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${title}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: num,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Color.fromARGB(30, 0, 169, 181),
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: AppCubit.get(context).number,
                          cornerStyle: CornerStyle.bothCurve,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Colors.blue, // Set the color here
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            positionFactor: 0.1,
                            angle: 90,
                            widget: Text(
                               '${AppCubit.get(context).number} / ${number}',
                              style: const TextStyle(fontSize: 20),
                            ))
                      ])
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue,

                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: MaterialButton(
                        onPressed: () {
AppCubit.get(context).changeValueNumber(number!,id!);
                        },
                        child: const Text(
                          "قم بدعاء",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
