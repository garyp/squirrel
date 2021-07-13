import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MarkdownTextEditingController extends TextEditingController {
  MarkdownTextEditingController({String? text}) : super(text: text);

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
/*
    final doc = md.Document(
      inlineSyntaxes: [WikiLinkSyntax(context), TaskListSyntax()],
      extensionSet: md.ExtensionSet.gitHubFlavored,
      encodeHtml: false,
    );
    final astNodes = doc.parseLines(LineSplitter().convert(text));

    final visitor = _MdNodeVisitor(text, style);
    for (final node in astNodes) {
      node.accept(visitor);
    }
    final spans = visitor.spans;
    spans.add(TextSpan(text: text.substring(visitor.lastPos)));
*/
    var lastPos = 0;
    final spans = <TextSpan>[];
    // final boldStyle = style?.merge(TextStyle(fontWeight: FontWeight.bold));
    final linkStyle = style?.merge(
        TextStyle(decoration: TextDecoration.underline, color: Colors.blue));

    for (final match in RegExp(r'\[\[[^\]]+\]\]').allMatches(text)) {
      spans.add(TextSpan(text: match.input.substring(lastPos, match.start)));
      spans.add(TextSpan(
          text: match.input.substring(match.start, match.end),
          style: linkStyle));
      lastPos = match.end;
    }

    spans.add(TextSpan(text: text.substring(lastPos)));

    return TextSpan(
      style: style,
      children: spans,
    );
  }
}

/*
class _MdNodeVisitor extends md.NodeVisitor {
  _MdNodeVisitor(String text, TextStyle? style)
      : _text = text,
        _style = style,
        _boldStyle = style?.merge(TextStyle(fontWeight: FontWeight.bold));

  final String _text;
  final TextStyle? _style;

  final spans = <TextSpan>[];
  var lastPos = 0;
  final TextStyle? _boldStyle;

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    if (element.attributes.containsKey('x-pos-start')) {
      final start = int.parse(element.attributes['x-pos-start']!);
      final end = int.parse(element.attributes['x-pos-end']!);
      spans.add(TextSpan(text: _text.substring(lastPos, start)));
      spans.add(TextSpan(text: _text.substring(start, end), style: _boldStyle));
      lastPos = end;
    }
    return true;
  }

  @override
  void visitText(md.Text text) {}
}
*/
