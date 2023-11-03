import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int day = 1;
  int month = 1;
  int year = 2000;
  String dayOfWeek = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatDayApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Date:',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20, // You can adjust the fontSize as needed
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue, // You can specify the border color here
                      width: 0.2,          // You can specify the border width here
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Day'),
                        onChanged: (value) {
                          day = int.tryParse(value) ?? 1;
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue, // You can specify the border color here
                      width: 0.2,          // You can specify the border width here
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Month'),
                        onChanged: (value) {
                          month = int.tryParse(value) ?? 1;
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue, // You can specify the border color here
                      width: 0.2,          // You can specify the border width here
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0), // Adjust the padding as needed
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Year'),
                        onChanged: (value) {
                          year = int.tryParse(value) ?? 1;
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                findDayOfWeek();
              },
              child: Text('Find Day of the Week'),
            ),
            SizedBox(height: 20),
            Text('Day of the Week: $dayOfWeek'),
          ],
        ),
      ),
    );
  }

  void findDayOfWeek() {
    if (isValidDate(day, month, year)) {
      int k = day;
      int m = (month - 3) % 12 + 1;
      int D = year % 100;
      int C = year ~/ 100;

      if (m <= 2) {
        m += 12;
        D -= 1;
      }

      int f = k + ((13 * m + 2) / 5).floor() + D + (D / 4).floor() + (C / 4).floor() - (2 * C) % 7;

      List<String> daysOfWeek = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

      dayOfWeek = daysOfWeek[(f % 7).toInt()];
    } else {
      dayOfWeek = "Invalid Date";
    }

    setState(() {});
  }

  bool isValidDate(int day, int month, int year) {
    if (year > 1000 && year<=9999 && month >= 1 && month <= 12) {
      int lastDayOfMonth = DateTime(year, month + 1, 0).day;
      return day >= 1 && day <= lastDayOfMonth;
    }
    return false;
  }
}