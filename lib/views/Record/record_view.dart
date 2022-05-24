import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/models/record.dart';
import 'package:employee_app/setting/preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  Record record = Record(userId: Preferences.getUserId()!);
  late Future<List> data;

  @override
  void initState() {
    super.initState();
    data = record.getRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: data,
            builder: (context, recordData) {
              if (recordData.hasData) {
                List recordList = recordData.data as List;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: recordList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        recordCard(recordList, index),
                        //recordMap(recordList[index]['locationIN'],
                        // recordList[index]['locationOUT'])
                      ],
                    );
                  },
                );
              }
              return const CircularProgressIndicator.adaptive();
            }));
  }

  Widget recordCard(List recordList, int index) {
    final timeIN = DateFormat.jm().format(recordList[index]['IN'].toDate());
    String timeOUT = '';
    if (recordList[index]['OUT'] != null) {
      timeOUT = DateFormat.jm().format(recordList[index]['OUT'].toDate());
    }
    String date =
        DateFormat.yMMMMd('en_US').format(recordList[index]['IN'].toDate());

    return Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffFDBF05), width: 3),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                date,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "IN: $timeIN",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFDBF05)),
              ),
              Text(
                "OUT: $timeOUT",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // google map
              // recordMap(recordList[index]['locationIN'],
              //     recordList[index]['locationOUT'])
            ],
          ),
        ));
  }

  Widget recordMap(GeoPoint timeIn, GeoPoint timeOut) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // time In
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(timeIn.latitude, timeIn.longitude))),

          // time Out
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(timeOut.latitude, timeOut.longitude)))
        ],
      ),
    );
  }
}
