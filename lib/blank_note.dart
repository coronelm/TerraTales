import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BlankNotePage extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;

  BlankNotePage({this.initialTitle, this.initialContent});

  @override
  _BlankNotePageState createState() => _BlankNotePageState();
}

class _BlankNotePageState extends State<BlankNotePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool _bold = false;
  bool _italic = false;
  bool _underline = false;
  Color _textColor = Colors.black;
  Color _bgColor = Colors.transparent;
  double _fontSize = 13.0;
  late String _lastTitle;
  late String _lastContent;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _contentController.text = widget.initialContent ?? '';
    _lastTitle = _titleController.text;
    _lastContent = _contentController.text;
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
              Navigator.pop(context, {'delete': true});
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
        title: Text(
          'ALL NOTES',
          style: TextStyle(color: Color(0xFF757121)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF757121)),
        actions: [
          IconButton(
            icon: Icon(Icons.undo, color: Color(0xFF757121)),
            onPressed: () {
              setState(() {
                _titleController.text = _lastTitle;
                _contentController.text = _lastContent;
              });
            },
          ),
          IconButton(
            icon: Text(
              'Done',
              style: TextStyle(color: Color(0xFF757121)),
            ),
            onPressed: () {
              if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
                Navigator.pop(context, {
                  'title': _titleController.text,
                  'content': _contentController.text,
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Color(0xFF757121)),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF757121),
              ),
              decoration: InputDecoration(
                hintText: 'TITLE',
                border: InputBorder.none,
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
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _bold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _italic ? FontStyle.italic : FontStyle.normal,
                  decoration: _underline ? TextDecoration.underline : TextDecoration.none,
                  color: _textColor,
                  backgroundColor: _bgColor,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.format_list_bulleted, color: Color(0xFF757121)),
                onPressed: _insertBullet,
              ),
              IconButton(
                icon: Icon(Icons.format_bold, color: _bold ? Colors.black : Colors.grey),
                onPressed: () {
                  setState(() {
                    _bold = !_bold;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.format_italic, color: _italic ? Colors.black : Colors.grey),
                onPressed: () {
                  setState(() {
                    _italic = !_italic;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.format_underline, color: _underline ? Colors.black : Colors.grey),
                onPressed: () {
                  setState(() {
                    _underline = !_underline;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.format_color_text, color: _textColor),
                onPressed: () {
                  _pickTextColor();
                },
              ),
              IconButton(
                icon: Icon(Icons.format_color_fill, color: _bgColor),
                onPressed: () {
                  _pickBackgroundColor();
                },
              ),
              DropdownButton<double>(
                value: _fontSize,
                icon: Icon(Icons.arrow_drop_down, color: Color(0xFF757121)),
                onChanged: (double? newValue) {
                  setState(() {
                    _fontSize = newValue!;
                  });
                },
                items: <double>[10, 12, 13, 15, 18, 20, 24, 30, 36]
                    .map<DropdownMenuItem<double>>((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString(), style: TextStyle(color: Color(0xFF757121))),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickTextColor() async {
    Color newColor = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a text color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _textColor,
            onColorChanged: (color) {
              Navigator.of(context).pop(color);
            },
          ),
        ),
      ),
    );
    setState(() {
      _textColor = newColor;
    });
  }

  void _pickBackgroundColor() async {
    Color newColor = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a background color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _bgColor,
            onColorChanged: (color) {
              Navigator.of(context).pop(color);
            },
          ),
        ),
      ),
    );
    setState(() {
      _bgColor = newColor;
    });
  }
}
