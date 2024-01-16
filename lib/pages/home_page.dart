import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/pages/add_note_page.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:notes/widgets/note_tile_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black87, letterSpacing: 5)),
        centerTitle: true,

      ),
      body: (notesProvider.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (notesProvider.notes.isNotEmpty)
              ? GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (context, index) {
                    NoteModel currentNote = notesProvider.notes[index];

                    return GestureDetector(
                      onLongPress: () {
                        // Delete
                        notesProvider.deleteNote(currentNote);
                      },
                      onTap: () {
                        // Update
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (_) => AddNotePage(
                                      isUpdate: true,
                                      note: currentNote,
                                    )));
                      },
                      child: noteTileWidget(
                        currentNote.title!,
                        currentNote.content!,
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => const AddNotePage(isUpdate: false),
                  fullscreenDialog: true),
          );
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
