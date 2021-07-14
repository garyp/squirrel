import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pds/models/note.dart';
import 'package:pds/models/note_collection.dart';
import 'package:pds/routes.gr.dart';
import 'package:pds/widgets/note_editor.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatelessWidget {
  const NoteEditScreen(@PathParam('noteId') this.noteId, {Key? key})
      : super(key: key);

  final String noteId;

  @override
  Widget build(BuildContext context) {
    final note = context.select(
        (NoteCollection noteCollection) => noteCollection.getById(noteId));

    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
        onTap: () => _showEditTitleDialog(context, note),
        child: Text(note.title),
      )),
      body: SingleChildScrollView(
        key: ValueKey(noteId),
        child: NoteEditor(note),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () => context.navigateTo(NoteDetailsRoute(noteId: noteId)),
      ),
    );
  }

  void _showEditTitleDialog(BuildContext context, Note note) async {
    final controller = TextEditingController(text: note.title);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Title'),
          content: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(controller.text),
                child: const Text('OK')),
          ],
        );
      },
    );
    if (newTitle != note.title) {
      context.read<NoteCollection>().updateNote(note.id, title: newTitle);
    }
  }
}
