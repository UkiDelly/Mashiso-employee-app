import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String userName;

  Employee({
    this.userName = "",
  });

  String? userId = "";
  String fullName = "";

  // check if employee is exists
  Future<bool> checkEmployee() async {
    final employee = await FirebaseFirestore.instance
        .collection('employee')
        .where('username', isEqualTo: userName)
        .get();

    // check if there is data
    if (employee.size == 0) {
      return false;
    }
    userId = employee.docs.first.id;
    fullName = employee.docs.first.data()['name'];

    return true;
  }
}
