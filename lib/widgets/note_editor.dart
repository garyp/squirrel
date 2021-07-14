import 'package:flutter/material.dart';
import 'package:pds/markdown/markdown_text_editing_controller.dart';
import 'package:pds/models/note.dart';
import 'package:pds/models/note_collection.dart';
import 'package:provider/provider.dart';

class NoteEditor extends StatefulWidget {
  final Note note;

  const NoteEditor(this.note, {Key? key}) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  late MarkdownTextEditingController _controller;

  static final _wikiLinkOpenTag = '[[';
  static final _wikiLinkCloseTag = ']]';

  @override
  void initState() {
    super.initState();
    _controller = MarkdownTextEditingController(text: widget.note.content);

    _controller.addListener(() {
      context
          .read<NoteCollection>()
          .updateNote(widget.note.id, content: _controller.text);
    });

    _controller.addListener(() async {
      final tev = _controller.value;
      if (!tev.selection.isValid || !tev.selection.isCollapsed) return;
      if (!tev.selection.textBefore(tev.text).endsWith(_wikiLinkOpenTag)) {
        return;
      }
      final linkTarget = await showDialog<Note>(
        context: context,
        builder: _buildAutocompleteDialog,
      );

      if (linkTarget != null) {
        _controller.value = TextEditingValue(
          text: (StringBuffer()
                ..write(tev.selection.textBefore(tev.text))
                ..write(linkTarget.title)
                ..write(_wikiLinkCloseTag)
                ..write(tev.selection.textAfter(tev.text)))
              .toString(),
          selection: TextSelection.collapsed(
              offset: tev.selection.start +
                  linkTarget.title.length +
                  _wikiLinkCloseTag.length),
          composing: TextRange.empty,
        );
      }
    });
  }

  Dialog _buildAutocompleteDialog(BuildContext context) {
    return Dialog(
      child: Autocomplete<Note>(
        optionsBuilder: (textEditingValue) {
          return context
              .read<NoteCollection>()
              .findNotesWithMatchingTitles(textEditingValue.text);
        },
        displayStringForOption: (option) => option.title,
        onSelected: (option) => Navigator.pop(context, option),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: _controller,
    );
  }
}
