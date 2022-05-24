import 'package:employee_app/models/record.dart';
import 'package:employee_app/setting/preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TimeInOutWidget extends StatefulWidget {
  const TimeInOutWidget({Key? key}) : super(key: key);

  @override
  State<TimeInOutWidget> createState() => _TimeInOutWidgetState();
}

class _TimeInOutWidgetState extends State<TimeInOutWidget> {
  //
  bool? status = false;
  String? userId = Preferences.getUserId();
  late Record record;
  late DateTime time;
  late Position currentLocation;

  // Time in
  timeIn() async {
    time = DateTime.now();
    currentLocation = await Geolocator.getCurrentPosition();
    record = Record(userId: userId!, time: time, location: currentLocation);

    record.timeInUpload();
    //
    await Preferences.setInOut(true);
    setState(() {
      status = true;
    });
  }

  // Time out
  timeOut() async {
    time = DateTime.now();
    currentLocation = await Geolocator.getCurrentPosition();
    record = Record(userId: userId!, time: time, location: currentLocation);

    record.timeOutUpLoad();
    //
    await Preferences.setInOut(false);
    setState(() {
      status = false;
    });
  }

  initStatus() async {
    status = Preferences.getInOut();
  }

  @override
  void initState() {
    super.initState();
    // initStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Time in/out
        Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Time in
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: (status == true)
                          ? const Color(0xffFDBF05)
                          : Colors.transparent,
                      border: Border.all(color: Colors.black, width: 5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: status == false
                        ? () {
                            print("Time in");
                            // Time in
                            timeIn();
                          }
                        : null,
                    child: const Center(
                        child: Text(
                      "IN",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                  ),
                ),
                const VerticalDivider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                ),

                //Time out
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: (status != true)
                          ? const Color(0xffFDBF05)
                          : Colors.transparent,
                      border: Border.all(color: Colors.black, width: 5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: status == true
                        ? () {
                            print("Time out");

                            // Time out
                            timeOut();
                          }
                        : null,
                    child: const Center(
                        child: Text(
                      "OUT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
