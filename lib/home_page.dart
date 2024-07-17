import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'blank_note.dart';
import 'calendar_page.dart';
import 'tools_page.dart';
import 'profile_page.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String email;

  HomePage({required this.name, required this.email});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _notes = [
    {"title": "CROPS", "content": "Harvested approximately 450 this month of June. Regularly check for pests and diseases, apply."},
    {"title": "TODAY’S SCHEDULE", "content": "1. Plant rice, onions, and tomatoes.\n2. Harvest lettuces and cucumbers."},
    {"title": "REPORTS", "content": "1. Ensure adequate water supply, especially during dry spells.\n2. Follow recommended fertilization schedules to maintain soil fertility.\n3. Maintain detailed records of harvest dates, yields, and any issues."},
    {"title": "CROPLIST TO BUY", "content": "Wheat, Corn, Carrots, Spinach, Strawberry, Orange, Apple"},
    {"title": "TOOLS LIST", "content": "Hoe - Used for weeding and soil cultivation.\nShovel - Used for digging, moving soil, and planting."}
  ];
  List<Map<String, String>> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _filteredNotes = _notes;
  }

  void _filterNotes(String query) {
    final notes = _notes.where((note) {
      final noteLower = (note["title"]! + "\n" + note["content"]!).toLowerCase();
      final queryLower = query.toLowerCase();

      return noteLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredNotes = notes;
    });
  }

  void _updateNote(Map<String, String> updatedNote, int index) {
    setState(() {
      _notes[index] = updatedNote;
      _filteredNotes = _notes;
    });
  }

  void _addNote(Map<String, String> note) {
    setState(() {
      _notes.add(note);
      _filteredNotes = _notes;
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
      _filteredNotes = _notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terra Tales', style: TextStyle(color: Color(0xFF757121))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF757121)),
      ),
      drawer: AppDrawer(name: widget.name, email: widget.email),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Notes',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _filterNotes,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                itemCount: _filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = _filteredNotes[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        note["title"]!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF757121),
                        ),
                      ),
                      subtitle: Text(note["content"]!),
                      onTap: () async {
                        final updatedNote = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlankNotePage(
                              initialTitle: note["title"],
                              initialContent: note["content"],
                            ),
                          ),
                        );
                        if (updatedNote != null) {
                          if (updatedNote['delete'] == true) {
                            _deleteNote(index);
                          } else {
                            _updateNote(updatedNote, index);
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlankNotePage()),
          );
          if (newNote != null) {
            _addNote({
              "title": newNote['title'],
              "content": newNote['content'],
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF757121),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Color(0xFF757121),
              onPressed: () {
                // Current page
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              color: Color(0xFF757121),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarPage(
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              },
            ),
            SizedBox(width: 40), // The dummy child
            IconButton(
              icon: Icon(Icons.build),
              color: Color(0xFF757121),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToolsPage(
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: Color(0xFF757121),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
