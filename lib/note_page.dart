import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final String title;
  final String content;

  NotePage({required this.title, required this.content});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL NOTES'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () {
              // Undo functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete note functionality
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // Save changes functionality
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Text',
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.check_box),
              onPressed: () {
                // Add checklist functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.text_format),
              onPressed: () {
                // Change text style functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.format_color_text),
              onPressed: () {
                // Change text color functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.format_color_fill),
              onPressed: () {
                // Change background color functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.format_size),
              onPressed: () {
                // Adjust font size functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
