// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:flutter/widgets.dart' as _i6;

import 'screens/note_details_screen.dart' as _i4;
import 'screens/note_edit_screen.dart' as _i5;
import 'screens/notes_list_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    NotesListRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.NotesListScreen();
        }),
    NoteDetailsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<NoteDetailsRouteArgs>(
              orElse: () =>
                  NoteDetailsRouteArgs(noteId: pathParams.getString('noteId')));
          return _i4.NoteDetailsScreen(args.noteId, key: args.key);
        }),
    NoteEditRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<NoteEditRouteArgs>(
              orElse: () =>
                  NoteEditRouteArgs(noteId: pathParams.getString('noteId')));
          return _i5.NoteEditScreen(args.noteId, key: args.key);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/notes', fullMatch: true),
        _i1.RouteConfig(NotesListRoute.name, path: '/notes'),
        _i1.RouteConfig(NoteDetailsRoute.name, path: '/notes/:noteId'),
        _i1.RouteConfig(NoteEditRoute.name, path: '/notes/:noteId/edit')
      ];
}

class NotesListRoute extends _i1.PageRouteInfo {
  const NotesListRoute() : super(name, path: '/notes');

  static const String name = 'NotesListRoute';
}

class NoteDetailsRoute extends _i1.PageRouteInfo<NoteDetailsRouteArgs> {
  NoteDetailsRoute({required String noteId, _i6.Key? key})
      : super(name,
            path: '/notes/:noteId',
            args: NoteDetailsRouteArgs(noteId: noteId, key: key),
            rawPathParams: {'noteId': noteId});

  static const String name = 'NoteDetailsRoute';
}

class NoteDetailsRouteArgs {
  const NoteDetailsRouteArgs({required this.noteId, this.key});

  final String noteId;

  final _i6.Key? key;
}

class NoteEditRoute extends _i1.PageRouteInfo<NoteEditRouteArgs> {
  NoteEditRoute({required String noteId, _i6.Key? key})
      : super(name,
            path: '/notes/:noteId/edit',
            args: NoteEditRouteArgs(noteId: noteId, key: key),
            rawPathParams: {'noteId': noteId});

  static const String name = 'NoteEditRoute';
}

class NoteEditRouteArgs {
  const NoteEditRouteArgs({required this.noteId, this.key});

  final String noteId;

  final _i6.Key? key;
}
