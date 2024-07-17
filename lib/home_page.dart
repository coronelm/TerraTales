import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'drawer.dart';
import 'notes_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> notes = [];

  void _addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotesScreen()),
    );

    if (result != null) {
      setState(() {
        notes.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terra Tales',
          style: TextStyle(
            color: Color(0xFF697719), // Subtitle color
            fontFamily: 'BrightRetro',
          ),
        ),
        backgroundColor: Color(0xFFF5F1D8), // Background color of AppBar
        iconTheme: IconThemeData(color: Colors.brown), // Icon color
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.brown),
            onPressed: _addNote,
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: notes.isEmpty
            ? Center(
                child: Text(
                  'No Notes',
                  style: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Poppins',
                  ),
                ),
              )
            : MasonryGridView.count(
                crossAxisCount: 2,
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    color: Color(0xFFF5F1D8), // Background color of Card
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note['title'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              fontFamily: 'Poppins',
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            note['note'] ?? '',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.brown),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.brown),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build, color: Colors.brown),
            label: 'Tools',
          ),
        ],
        selectedItemColor: Color(0xFF697719), // Subtitle color
        backgroundColor: Color(0xFFF5F1D8), // Background color of BottomNavBar
      ),
    );
  }
}