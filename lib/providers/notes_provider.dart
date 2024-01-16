import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/services/api_services.dart';

class NotesProvider with ChangeNotifier {

  bool isLoading = true;
  List<NoteModel> notes = [];

  NotesProvider(){
    fetchNotes();
  }

  void sortNotes(){
    notes.sort((b, a) => a.dateadded!.compareTo(b.dateadded!));
  }

  void addNote(NoteModel note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    APIService.addNote(note);
  }

  void updateNote(NoteModel note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    APIService.addNote(note);
  }

  void deleteNote(NoteModel note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    APIService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await APIService.fetchNotes('vrundraval');
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}
