import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/book.dart';
import '../blocs/book/book_bloc.dart';
import '../blocs/book/book_event.dart';
import '../blocs/book/book_state.dart';

class DetailPage extends StatelessWidget {
  final Book book;

  DetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    // Check favorite status when page loads
    context.read<BookBloc>().add(CheckFavoriteStatus(book));

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        actions: [
          BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is FavoriteStatus) {
                return IconButton(
                  icon: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: state.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    if (state.isFavorite) {
                      context.read<BookBloc>().add(RemoveFromFavorites(book));
                    } else {
                      context.read<BookBloc>().add(AddToFavorites(book));
                    }
                  },
                );
              }
              return IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  context.read<BookBloc>().add(AddToFavorites(book));
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.imageUrl.isNotEmpty)
              Container(
                width: double.infinity,
                height: 300,
                child: CachedNetworkImage(
                  imageUrl: book.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.book, size: 80, color: Colors.grey[400]),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    book.author,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[700],
                        ),
                  ),
                  SizedBox(height: 16),
                  if (book.description.isNotEmpty) ...[
                    Text(
                      book.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.favorite_outline),
                      label: Text('Add to Favorites'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () async {
                        try {
                          await dbService.addToFavorites(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Added to favorites',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error adding to favorites',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
