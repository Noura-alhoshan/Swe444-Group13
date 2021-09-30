import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meras1/screen/admin/ADcategory.dart';
import 'package:meras1/screen/tranee/Coachlist.dart';
import 'package:meras1/screen/admin/Dashboard.dart';
import 'package:meras1/Test.dart';

import 'screen/tranee/TRcategory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginScreen(),
      '/dashboard': (context) => DashboardScreen(),
      // '/Test': (context) => TestScreen(),
      '/coachlist': (context) => CoachlistScreen(),
      '/ADcategory': (context) => ADcategory(),
      '/TRcategory': (context) => TRcategory(),
    },
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('PENDING CHOACH LIST'),
                  onPressed: () {
                    nav();
                  },
                  color: Colors.white,
                ),
                FlatButton(
                  child: Text('Tranee'),
                  onPressed: () {
                    nav2();
                  },
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('Admin'),
                  onPressed: () {
                    nav1();
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nav1() async {
    Navigator.pushNamed(context, '/ADcategory'); //nn
  }

  void nav() async {
    Navigator.pushNamed(context, '/dashboard'); //nn
  }

  void nav2() async {
    Navigator.pushNamed(context, '/TRcategory'); //nn
  }
}
//
