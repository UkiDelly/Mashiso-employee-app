import 'package:employee_app/views/Home/time_in_out.dart';
import 'package:flutter/material.dart';

import 'google_map.dart';

class TimeInOutView extends StatelessWidget {
  String fullName;
  TimeInOutView({Key? key, required this.fullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/mashiso.png',
                scale: 8,
              ),
            ),
          ),

          //
          const SizedBox(
            height: 20,
          ),

          // full name
          //Name
          Card(
              elevation: 5,
              color: const Color(0xffFDBF05),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        fullName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )),

          //
          const SizedBox(
            height: 20,
          ),

          // Time in/out and google map
          const TimeInOutWidget(),

          //
          const SizedBox(
            height: 20,
          ),

          // google map
          const GoogleMapWidget(),

          //
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
