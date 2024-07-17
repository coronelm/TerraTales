import 'package:flutter/material.dart';

class CalendarOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Terra Tales',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Color(0xFF757121),
          ),
        ),
      ),
      body: Column(
        children: [
          // Add your calendar overview content here
        ],
      ),
    );
  }
}
