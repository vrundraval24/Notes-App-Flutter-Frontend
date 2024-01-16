import 'dart:convert';
import 'dart:developer';

import 'package:notes/models/note_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String _baseURL =
      "https://notes-app-service-pb6t.onrender.com/notes";

  static Future<void> addNote(NoteModel note) async {
    Uri requestUri = Uri.parse('$_baseURL/add');
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }


  static Future<void> deleteNote(NoteModel note) async {
    Uri requestUri = Uri.parse('$_baseURL/delete');
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }


  static Future<List<NoteModel>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse('$_baseURL/list');
    var response = await http.post(requestUri, body: { "userid": userid });
    var decoded = jsonDecode(response.body);
    
    List<NoteModel> notesList = [];
    for(var noteMap in decoded){
      NoteModel newNote = NoteModel.fromMap(noteMap);
      notesList.add(newNote);
    }

    return notesList;
  }
}
