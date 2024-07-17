import 'package:flutter/material.dart';
import 'home_page.dart';
import 'calendar_page.dart';
import 'tools_page.dart';
import 'landing_page.dart';

class AppDrawer extends StatelessWidget {
  final String name;
  final String email;

  AppDrawer({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(name[0]),
            ),
          ),
          ListTile(
            leading: Icon(Icons.note, color: Color(0xFF757121)),
            title: Text('All Notes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(name: name, email: email)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today, color: Color(0xFF757121)),
            title: Text('Calendar'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage(name: name, email: email)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.build, color: Color(0xFF757121)),
            title: Text('Tools & Equipment'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToolsPage(name: name, email: email)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Color(0xFF757121)),
            title: Text('Exit'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
