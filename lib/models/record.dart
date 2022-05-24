import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import '../setting/preferences.dart';

class Record {
  final String userId;
  final DateTime? time;
  final Position? location;

  Record({required this.userId, this.time, this.location});

  // Time in
  timeInUpload() async {
    var userId = Preferences.getUserId();
    await FirebaseFirestore.instance
        .collection('employee')
        .doc(userId)
        .collection('record')
        .add({
      'IN': Timestamp.fromDate(time!),
      'locationIN': GeoPoint(location!.latitude, location!.longitude)
    });

    Fluttertoast.showToast(
        msg: "Successfully Time in!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 20.0);
  }

  // Time out
  timeOutUpLoad() async {
    var userId = Preferences.getUserId();
    final employee = await FirebaseFirestore.instance
        .collection('employee')
        .doc(userId)
        .collection('record')
        .orderBy('IN', descending: true)
        .get();

    String id = employee.docs.first.id;
    await FirebaseFirestore.instance
        .collection('employee')
        .doc(userId)
        .collection('record')
        .doc(id)
        .update({
      "OUT": Timestamp.fromDate(time!),
      "locationOUT": GeoPoint(location!.latitude, location!.longitude)
    });

    Fluttertoast.showToast(
        msg: "Successfully Time Out!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 20.0);
  }

  // get Record
  Future<List> getRecord() async {
    List data = [];
    final employee = await FirebaseFirestore.instance
        .collection('employee')
        .doc(userId)
        .collection('record')
        .orderBy('IN', descending: true)
        .get();

    for (int i = 0; i < employee.docs.length; i++) {
      data.add(employee.docs[i].data());
    }

    return data;
  }
}
