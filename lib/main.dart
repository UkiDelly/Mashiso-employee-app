import 'package:employee_app/FireBase/firebase_options.dart';
import 'package:employee_app/setting/preferences.dart';
import 'package:employee_app/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Shared Preferences
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: "Inter",
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xffF9BF06),
                onPrimary: Color(0xffffffff),
                secondary: Color(0xffF44336),
                onSecondary: Color(0xffffffff),
                error: Color(0xffBA1B1B),
                onError: Color(0xffffffff),
                background: Color(0xffFFFBF8),
                onBackground: Color(0xff1E1B16),
                surface: Color(0xffFFFBF8),
                onSurface: Color(0xff1E1B16))),
        darkTheme: ThemeData(
            colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xffF9BF06),
          onPrimary: Color(0xffffffff),
          secondary: Color(0xffF44336),
          onSecondary: Color(0xffffffff),
          error: Color(0xffFFB4A9),
          onError: Color(0xff680003),
          background: Color(0xff1B1B1B),
          onBackground: Color(0xffE2E2E6),
          surface: Color(0xff1B1B1B),
          onSurface: Color(0xffE2E2E6),
        )),
        home: const LoginView());
  }
}
