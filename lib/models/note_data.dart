import 'package:day_36_with_flutter/data/hive_database.dart';
import 'package:flutter/material.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Note> allNotes = [];

  void initializeNote() {
    allNotes = db.loadNotes();
  }

  List<Note> getAllNotes() {
    return allNotes;
  }

  void addNewNote(Note note) {
    allNotes.add(note);
    db.savedNotes(allNotes);
    notifyListeners();
  }

  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    db.savedNotes(allNotes);
    notifyListeners();
  }

  void deleteNote(Note note) {
    allNotes.remove(note);
    db.savedNotes(allNotes);
    notifyListeners();
  }
}
