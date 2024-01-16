import 'package:flutter/material.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey[100]),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.black),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, primary: Colors.black),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
