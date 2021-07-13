import 'dart:convert';

import 'package:charcode/ascii.dart';
import 'package:flutter/widgets.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:pds/models/note_collection.dart';
import 'package:provider/provider.dart';

class WikiLinkSyntax extends md.InlineSyntax {
  WikiLinkSyntax(BuildContext context)
      : _context = context,
        super(r'\[\[([^\]]+)\]\]', startCharacter: $lbracket);

  final BuildContext _context;

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final linkTitle = match[1]!;
    final note = _context.read<NoteCollection>().getByTitle(linkTitle);
    final url = 'note:${note.id}';
    final text =
        parser.document.encodeHtml ? _escapeHtml(linkTitle) : linkTitle;
    final anchor = md.Element.text('a', text);
    anchor.attributes['href'] = Uri.encodeFull(url);
    parser.addNode(anchor);

    return true;
  }
}

String _escapeHtml(String html) =>
    const HtmlEscape(HtmlEscapeMode.element).convert(html);
