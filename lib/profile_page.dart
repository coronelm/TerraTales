import 'package:flutter/material.dart';
import 'home_page.dart';
import 'calendar_page.dart';
import 'tools_page.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;

  ProfilePage({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Color(0xFF757121),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Text(
                name[0],
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFF757121),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              email,
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF757121),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 3,
        selectedItemColor: Color(0xFF757121),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(name: name, email: email)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage(name: name, email: email)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToolsPage(name: name, email: email)),
              );
              break;
            case 3:
              // Current Page
              break;
          }
        },
      ),
    );
  }
}
