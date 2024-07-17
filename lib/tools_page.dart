import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'calendar_page.dart';

class ToolsPage extends StatelessWidget {
  final String name;
  final String email;

  ToolsPage({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools & Equipment'),
        backgroundColor: Color(0xFF757121),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Rake'),
            trailing: DropdownButton<String>(
              value: 'Good to Use',
              items: <String>['Good to Use', 'For Repair', 'Needs Replacement']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
          ListTile(
            title: Text('Shovel'),
            trailing: DropdownButton<String>(
              value: 'For Repair',
              items: <String>['Good to Use', 'For Repair', 'Needs Replacement']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
          ListTile(
            title: Text('Hedge Shear'),
            trailing: DropdownButton<String>(
              value: 'Needs Replacement',
              items: <String>['Good to Use', 'For Repair', 'Needs Replacement']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
          ListTile(
            title: Text('Trowel'),
            trailing: DropdownButton<String>(
              value: 'Needs Replacement',
              items: <String>['Good to Use', 'For Repair', 'Needs Replacement']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
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
        currentIndex: 2,
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
              // Current page
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
