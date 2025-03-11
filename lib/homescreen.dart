import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posrtman_pd/apiservice.dart';
import 'package:posrtman_pd/counterscreen.dart';

class PostmanPD extends StatefulWidget {
  const PostmanPD({super.key});
  @override
  State<PostmanPD> createState() => _PostmanPDState();
}

class _PostmanPDState extends State<PostmanPD> {
  final _textController = TextEditingController();
  List<String> name = [];
  int selectedIndex = -1; 
  final ApiService apiService = ApiService(); 

  void _showAddCounterDialog() {
    _textController.clear();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Counter', style: GoogleFonts.poppins()),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Enter Counter Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_textController.text.isNotEmpty) {
                final newName = _textController.text;
                
                setState(() {
                  name.add(newName);
                  selectedIndex = name.length - 1;
                });
                
                await apiService.createCounter(newName, selectedIndex);
                _textController.clear();
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App', style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color.fromARGB(255, 255, 132, 0), const Color.fromARGB(255, 244, 89, 54)],
            ),
          ),
          padding: EdgeInsets.only(top: 50),
          child: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  name[index],
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                selected: index == selectedIndex,
                onTap: () {
                  setState(() {
                    selectedIndex = index; // Update selected index
                  });
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CounterScreen(
                        counterName: name[index],
                        index: index,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCounterDialog,
        tooltip: 'Add Counter',
        child: Icon(Icons.add),
      ),
    );
  }
}
