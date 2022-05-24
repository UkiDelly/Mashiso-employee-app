import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String userId;
  final DateTime time;
  final GeoPoint location;

  Record(this.userId, this.time, this.location);
}
