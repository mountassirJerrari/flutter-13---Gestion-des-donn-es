import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/book/book_bloc.dart';
import 'pages/homepage.dart';
import 'repositories/book_repository.dart';

void main() {
  runApp(BookApp());
}

class BookApp extends StatelessWidget {
  final bookRepository = BookRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(repository: bookRepository),
      child: MaterialApp(
        title: 'Book Manager',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.light(
            primary: Colors.indigo,
            secondary: Colors.pinkAccent,
            surface: Colors.grey[50]!,
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
