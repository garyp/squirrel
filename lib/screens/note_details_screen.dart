import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pds/models/note.dart';
import 'package:pds/models/note_collection.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatelessWidget {
  final String noteId;

  const NoteDetailsScreen(@PathParam('noteId') this.noteId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final note = context.select(
        (NoteCollection noteCollection) => noteCollection.getById(noteId));

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SelectableText(note.title,
              //     style: Theme.of(context).textTheme.headline6),
              MarkdownBody(data: note.content, selectable: true),
              Divider(),
              NoteEditor(note),
            ],
          )),
    );
  }
}

class NoteEditor extends StatefulWidget {
  final Note note;

  const NoteEditor(this.note, {Key? key}) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState(note);
}

class _NoteEditorState extends State<NoteEditor> {
  final Note _note;
  final MarkdownTextEditingController _controller;

  _NoteEditorState(Note note)
      : _note = note,
        _controller = MarkdownTextEditingController(text: note.content);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      context.read<NoteCollection>().updateNote(_note.id, _controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: null,
    );
  }
}

class MarkdownTextEditingController extends TextEditingController {
  MarkdownTextEditingController({String? text}) : super(text: text);

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return super.buildTextSpan(
        context: context, style: style, withComposing: withComposing);
  }
}
