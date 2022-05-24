import 'package:employee_app/setting/preferences.dart';
import 'package:employee_app/views/Record/record_view.dart';

import 'package:employee_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Home/home.dart';

class HomeView extends StatefulWidget {
  String fullName;
  HomeView({Key? key, required this.fullName}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //
  int currentIndex = 0;
  PageController pageController = PageController();

  //* Change the Page
  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            // Time in/out Page
            TimeInOutView(fullName: widget.fullName),
            const RecordView()
          ],
        ),
      ),

      //
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: currentIndex,
        onTap: (index) async {
          print("current index: $currentIndex, pressed index:  $index");
          if (index == 2) {
            // Go back to main page and clean the userId
            await Preferences.saveUserId("");
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(PageTransition(
                child: const LoginView(), type: PageTransitionType.fade));
          }

          // Change page
          changePage(index);
        },
        items: const [
          // Home Button
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),

          // Record list Buttom
          BottomNavigationBarItem(
            label: "Record",
            icon: Icon(
              Icons.bar_chart,
            ),
          ),

          // Logout
          BottomNavigationBarItem(
            label: "Main",
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
