import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/db_service.dart';

class DetailPage extends StatelessWidget {
  final Book book;
  final dbService = DbService();

  DetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.imageUrl.isNotEmpty)
              Center(
                child: Image.network(
                  book.imageUrl,
                  height: 200,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.book, size: 200),
                ),
              ),
            SizedBox(height: 16),
            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              'Author: ${book.author}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.favorite),
              label: Text('Add to Favorites'),
              onPressed: () async {
                try {
                  await dbService.addToFavorites(book);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added to favorites')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error adding to favorites: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
