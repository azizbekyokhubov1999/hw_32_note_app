import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hw_32_note_app/pages/details_page.dart';
import 'package:hw_32_note_app/pages/home_page.dart';
import 'package:hw_32_note_app/services/hive_service/db_service.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(DBService.dbName);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/home_page',
      routes: {
        '/home_page': (context) => const HomePage(),
        '/details_page':(context) => const DetailPage()
      },
    );

  }
}
