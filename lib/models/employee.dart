import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String name;

  Employee({
    required this.name,
  });

  String userId = "";

  // check if employee is exists
  checkEmployee() async {
    final employee = await FirebaseFirestore.instance
        .collection('employee')
        .where('username', isEqualTo: name)
        .get();

    // check if there is data
    if (employee.size == 0) {
      return false;
    }
    userId = employee.docs.first.id;
    return true;
  }
}
