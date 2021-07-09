import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pds/models/note_collection.dart';
import 'package:pds/routes.gr.dart';
import 'package:provider/provider.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _NotesList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add Note',
        onPressed: () => context.navigateTo(NoteDetailsRoute(
            noteId: context.read<NoteCollection>().addNewNote())),
      ),
    );
  }
}

class _NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesLength = context
        .select((NoteCollection noteCollection) => noteCollection.notes.length);

    return ListView.separated(
      itemCount: notesLength,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => _NotesListItem(index),
    );
  }
}

class _NotesListItem extends StatelessWidget {
  final int position;

  const _NotesListItem(this.position, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final note = context.select((NoteCollection noteCollection) =>
        noteCollection.getByPosition(position));
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.id, style: TextStyle(fontStyle: FontStyle.italic)),
      onTap: () => context.navigateTo(NoteDetailsRoute(noteId: note.id)),
    );
  }
}
