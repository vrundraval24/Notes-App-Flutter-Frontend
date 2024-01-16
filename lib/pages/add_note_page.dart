import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, required this.isUpdate, this.note});

  final bool isUpdate;
  final NoteModel? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  FocusNode focusNode = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }

  }

  void addNewNote(){

    if(titleController.text.isNotEmpty && contentController.text.isNotEmpty){
      NoteModel newNote = NoteModel(
        id: const Uuid().v1(),
        userid: "vrundraval",
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now(),

      );

      Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
      Navigator.pop(context);
    }

  }

  void updateNote(){
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                if(widget.isUpdate){
                  updateNote();
                }else{
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: 'Title', border: InputBorder.none),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              autofocus: (widget.isUpdate) ? false : true,
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  focusNode.requestFocus();
                }
              },
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: focusNode,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Description', border: InputBorder.none),
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
