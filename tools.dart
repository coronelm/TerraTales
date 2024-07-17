// tools.dart
import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  final List<Map<String, String>> tools = [
    {'name': 'Axe', 'image': 'images/axe.jpg'},
    {'name': 'Dibber', 'image': 'images/dibber.jpg'},
    {'name': 'Garden Fork', 'image': 'images/garden_fork.jpg'},
    {'name': 'Garden Gloves', 'image': 'images/garden_gloves.jpg'},
    {'name': 'Garden Hoe', 'image': 'images/garden_hoe.jpg'},
    {'name': 'Loppers', 'image': 'images/loppers.jpg'},
    {'name': 'Mattock', 'image': 'images/mattock.jpg'},
    {'name': 'Rake', 'image': 'images/rake.jpg'},
    {'name': 'Shovel', 'image': 'images/shovel.jpg'},
    {'name': 'Sickle', 'image': 'images/sickle.jpg'},
    {'name': 'Trowel', 'image': 'images/trowel.jpg'},
    {'name': 'Weeder', 'image': 'images/weeder.jpg'},
    {'name': 'Wheel Barrow', 'image': 'images/wheel_barrow.jpg'},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tools',
          style: TextStyle(
            color: Color(0xFF697719), // Subtitle color
            fontFamily: 'BrightRetro',
          ),
        ),
        backgroundColor: Color(0xFFF5F1D8), // Background color of AppBar
        iconTheme: IconThemeData(color: Colors.brown), // Icon color
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];
          return Card(
            color: Color(0xFFF5F1D8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    tool['image']!,
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tool['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Poppins',
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: ['Good to Use', 'For Repair', 'Needs Replacement']
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
