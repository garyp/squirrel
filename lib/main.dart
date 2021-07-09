import 'package:flutter/material.dart';
import 'package:pds/models/app_state.dart';
import 'package:pds/models/note_collection.dart';
import 'package:pds/routes.gr.dart';
import 'package:pds/screens/notes_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(PdsApp());

class PdsApp extends StatefulWidget {
  const PdsApp({Key? key}) : super(key: key);

  @override
  _PdsAppState createState() => _PdsAppState();
}

class _PdsAppState extends State<PdsApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppState()),
          ChangeNotifierProvider(create: (context) => NoteCollection()),
        ],
        child: MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: 'Notes App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            )));
  }
}
