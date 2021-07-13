import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pds/markdown/wiki_link_syntax.dart';
import 'package:pds/models/note.dart';
import 'package:pds/routes.gr.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteViewer extends StatelessWidget {
  NoteViewer(this.note);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: note.content,
      selectable: true,
      inlineSyntaxes: [WikiLinkSyntax(context)],
      onTapLink: (text, href, title) async {
        if (href == null) return;
        if (href.startsWith('note:')) {
          context.navigateTo(NoteDetailsRoute(noteId: href.substring(5)));
        } else if (await canLaunch(href)) {
          await launch(href);
        } else {
          debugPrint("Can't open link: <$href>");
        }
      },
    );
  }
}
