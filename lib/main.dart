import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This is the entry point of the Flutter app.
    // It returns a MaterialApp widget, which is the root of the app.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: MyHomePage(), // Set the initial page to MyHomePage
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
      // Scaffold provides a basic app structure, including an app bar and body.
      appBar: AppBar(
        title: Text('WhatDayApp'), // AppBar with a title
      ),
      body: Center(
        // Center widget centers its child vertically and horizontally.
        child: Column(
          // Column widget arranges children in a vertical column.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Date:',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20, // Text widget with style properties.
              ),
            ),
            SizedBox(height: 20), // Adds spacing (SizedBox) between widgets.

            // Container widget for 'Day' input field.
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlue, // Border color
                  width: 0.2, // Border width
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Day'), // Input field with label
                    onChanged: (value) {
                      day = int.tryParse(value) ?? 1; // Update 'day' when text changes.
                    },
                  ),
                ),
              ),
            ),

            // Container widget for 'Month' input field.
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlue, // Border color
                  width: 0.2, // Border width
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Month'), // Input field with label
                    onChanged: (value) {
                      month = int.tryParse(value) ?? 1; // Update 'month' when text changes.
                    },
                  ),
                ),
              ),
            ),

            // Container widget for 'Year' input field.
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlue, // Border color
                  width: 0.2, // Border width
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Year'), // Input field with label
                    onChanged: (value) {
                      year = int.tryParse(value) ?? 1; // Update 'year' when text changes.
                    },
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                findDayOfWeek(); // ElevatedButton triggers 'findDayOfWeek' when pressed.
              },
              child: Text('Find Day of the Week'), // Button text
            ),
            SizedBox(height: 20), // Spacing

            Text('Day of the Week: $dayOfWeek'), // Display the calculated day of the week.
          ],
        ),
      ),
    );
  }

  void findDayOfWeek() {
    if (isValidDate(day, month, year)) {
      // Calculate the day of the week using Zeller's Congruence algorithm.

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
    // Update the UI to display the calculated day of the week.
  }

  bool isValidDate(int day, int month, int year) {
    // Check if the provided date is valid.

    if (year > 1000 && year <= 9999 && month >= 1 && month <= 12) {
      int lastDayOfMonth = DateTime(year, month + 1, 0).day;
      return day >= 1 && day <= lastDayOfMonth;
    }
    return false;
  }
}
