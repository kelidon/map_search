import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:map_search/screens/map_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'models/search_result.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(SearchResultAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MapScreen(),
    );
  }
}
