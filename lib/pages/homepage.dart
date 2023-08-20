import 'package:day_36_with_flutter/models/note.dart';
import 'package:day_36_with_flutter/models/note_data.dart';
import 'package:day_36_with_flutter/pages/editing_note_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNote();
    
  }

  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    Note newNote = Note(
      id: id,
      text: '',
    );

    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(
            note: note,
            isNewNote: isNewNote,
          ),
        ));
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          backgroundColor: Colors.grey[300],
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 70),
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              value.getAllNotes().length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(child: Text("Nothing here...",style: TextStyle(color: Colors.grey),)),
                    )
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                        value.getAllNotes().length,
                        (index) => CupertinoListTile(
                          title: Text(value.getAllNotes()[index].text),
                          onTap: () =>
                              goToNotePage(value.getAllNotes()[index], false),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.grey[300],
                            onPressed: () =>
                                deleteNote(value.getAllNotes()[index]),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
