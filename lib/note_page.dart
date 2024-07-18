import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final String title;
  final String content;
  final Function onDelete;

  NotePage({required this.title, required this.content, required this.onDelete});

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
    _contentController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _contentController.removeListener(_handleTextChange);
    _contentController.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    if (_contentController.text.endsWith('\n')) {
      _contentController.text = _contentController.text + '• ';
      _contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: _contentController.text.length),
      );
    }
  }

  void _insertBullet() {
    int start = _contentController.selection.start;
    int end = _contentController.selection.end;
    String selectedText = _contentController.text.substring(start, end);
    String newText = '• $selectedText';
    _contentController.text = _contentController.text.replaceRange(start, end, newText);
    _contentController.selection = TextSelection.collapsed(offset: start + 2);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              widget.onDelete();
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
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
            onPressed: _confirmDelete,
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
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
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
              icon: Icon(Icons.format_list_bulleted),
              onPressed: _insertBullet,
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
