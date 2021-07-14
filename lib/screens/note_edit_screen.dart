import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        title: Text(note.title),
      ),
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
}
