import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFF5F1D8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('images/farmer.png'), // Your image asset
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 16.0),
                Text(
                  'USERNAME:',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Farmer',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16.0,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.note, color: Colors.brown),
            title: Text(
              'All Notes',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Navigate to All Notes
            },
          ),
          ListTile(
            leading: Icon(Icons.archive, color: Colors.brown),
            title: Text(
              'Archived Notes',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Navigate to Archived Notes
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.brown),
            title: Text(
              'Trash',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Navigate to Trash
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.brown),
            title: Text(
              'Calendar',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Navigate to Calendar
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.brown),
            title: Text(
              'Help & Support',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Navigate to Help & Support
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.brown),
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Navigate to Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.brown),
            title: Text(
              'Log Out',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.brown,
              ),
            ),
            onTap: () {
              // Handle log out
            },
          ),
        ],
      ),
    );
  }
}
