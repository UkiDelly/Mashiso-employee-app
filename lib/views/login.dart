import 'package:employee_app/models/employee.dart';
import 'package:employee_app/setting/preferences.dart';
import 'package:employee_app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),

          // Logo
          Center(
            child: Image.asset(
              'assets/mashiso.png',
              scale: 8,
            ),
          ),

          // input
          const _LoginViews(),

          const Spacer(flex: 3),
        ],
      )),
    );
  }
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginViews extends StatefulWidget {
  const _LoginViews({Key? key}) : super(key: key);

  @override
  State<_LoginViews> createState() => __LoginViewsState();
}

class __LoginViewsState extends State<_LoginViews> {
  //
  TextEditingController employeeNickName = TextEditingController();
  dynamic exist;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            //
            const SizedBox(
              height: 20,
            ),

            // employee nickname
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  controller: employeeNickName,
                  decoration: InputDecoration(
                      //
                      hintText: "Enter your name",
                      //
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2)),
                      //
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2)),
                      //
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                              width: 2)),
                      //
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                              width: 2)),
                      errorText:
                          exist == false ? "Employee is not exist" : null),
                  // validator
                  validator: (employeeName) {
                    if (employeeName == null || employeeName.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                )),

            //
            const SizedBox(
              height: 20,
            ),

            // Enter button
            SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                    onPressed: () async {
                      Employee employee = Employee(name: employeeNickName.text);

                      // if the text field is not empty
                      if (_formKey.currentState!.validate()) {
                        // check if the employee is exist
                        exist = await employee.checkEmployee();

                        if (exist) {
                          // saved the userId
                          await Preferences.saveUserId(employee.userId);

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(PageTransition(
                              child: const Home(),
                              type: PageTransitionType.fade));
                        }

                        setState(() {
                          exist;
                        });
                      }
                    },
                    child: const Text(
                      "Enter",
                      style: TextStyle(fontSize: 30),
                    )))
          ],
        ));
  }
}
