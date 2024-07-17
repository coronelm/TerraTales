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
  }

  void _insertCheckbox() {
    setState(() {
      final newText = _contentController.text + '\n[ ] ';
      _contentController.text = newText;
    });
  }

  void _toggleCheckbox(int index) {
    setState(() {
      List<String> lines = _contentController.text.split('\n');
      if (lines[index].startsWith('[ ]')) {
        lines[index] = lines[index].replaceFirst('[ ]', '[x]');
      } else if (lines[index].startsWith('[x]')) {
        lines[index] = lines[index].replaceFirst('[x]', '[ ]');
      }
      _contentController.text = lines.join('\n');
    });
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
            onPressed: () {
              Navigator.pop(context, {'delete': true});
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
              child: ListView.builder(
                itemCount: _contentController.text.split('\n').length,
                itemBuilder: (context, index) {
                  String line = _contentController.text.split('\n')[index];
                  return ListTile(
                    leading: line.startsWith('[ ]') || line.startsWith('[x]')
                        ? Checkbox(
                            value: line.startsWith('[x]'),
                            onChanged: (checked) {
                              _toggleCheckbox(index);
                            },
                          )
                        : null,
                    title: TextField(
                      controller: TextEditingController(text: line),
                      onChanged: (newLine) {
                        List<String> lines = _contentController.text.split('\n');
                        lines[index] = newLine;
                        _contentController.text = lines.join('\n');
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: _fontSize,
                        fontWeight: _bold ? FontWeight.bold : FontWeight.normal,
                        fontStyle: _italic ? FontStyle.italic : FontStyle.normal,
                        decoration: _underline ? TextDecoration.underline : TextDecoration.none,
                        color: _textColor,
                        backgroundColor: _bgColor,
                      ),
                    ),
                  );
                },
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
                icon: Icon(Icons.check_box_outlined, color: Color(0xFF757121)),
                onPressed: _insertCheckbox,
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
