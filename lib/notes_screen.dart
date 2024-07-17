import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Notes',
          style: TextStyle(
            color: Color(0xFF697719), // Subtitle color
            fontFamily: 'BrightRetro',
          ),
        ),
        backgroundColor: Color(0xFFF5F1D8), // Background color of AppBar
        iconTheme: IconThemeData(color: Colors.brown), // Icon color
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.brown),
            onPressed: () {
              // Save note logic here
              Navigator.pop(context, {
                'title': titleController.text,
                'note': noteController.text,
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.brown,
                  fontFamily: 'Poppins',
                ),
              ),
              style: TextStyle(
                color: Colors.brown,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: noteController,
                decoration: InputDecoration(
                  hintText: 'Note',
                  hintStyle: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Poppins',
                  ),
                ),
                style: TextStyle(
                  color: Colors.brown,
                  fontFamily: 'Poppins',
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}