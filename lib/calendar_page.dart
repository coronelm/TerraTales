import 'package:flutter/material.dart';
import 'home_page.dart'; 
import 'profile_page.dart'; 
import 'tools_page.dart'; 

class CalendarPage extends StatelessWidget {
  final String name;
  final String email;

  CalendarPage({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Color(0xFF757121),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('6:00 AM - 7:00 AM'),
            subtitle: Text('Ensure the irrigation system is functioning properly and water all crops as needed.'),
          ),
          ListTile(
            title: Text('7:00 AM - 9:00 AM'),
            subtitle: Text('Remove weeds manually in the vegetable garden. Inspect and replace any pest traps as needed.'),
          ),
          ListTile(
            title: Text('9:00 AM - 11:00 AM'),
            subtitle: Text('Fertilize the lettuce and spinach crops. Trim and prune fruit trees to promote healthy growth. Clean and maintain tools and equipment used in the morning.'),
          ),
        ],
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
        currentIndex: 1,
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
              // Current Page
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToolsPage(name: name, email: email)),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(name: name, email: email)),
              );
              break;
          }
        },
      ),
    );
  }
}
