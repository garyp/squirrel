import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pds/models/note_collection.dart';
import 'package:pds/routes.gr.dart';
import 'package:pds/widgets/note_viewer.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen(@PathParam('noteId') this.noteId, {Key? key})
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
        child: NoteViewer(note),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => context.navigateTo(NoteEditRoute(noteId: noteId)),
      ),
    );
  }
}
