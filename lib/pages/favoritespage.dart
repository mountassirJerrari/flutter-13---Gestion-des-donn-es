import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/book.dart';
import '../blocs/book/book_bloc.dart';
import '../blocs/book/book_event.dart';
import '../blocs/book/book_state.dart';
import 'detailpage.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load favorites when page opens
    context.read<BookBloc>().add(LoadFavorites());

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border,
                        size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final book = state.favorites[index];
                return Dismissible(
                  key: Key(book.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    context.read<BookBloc>().add(RemoveFromFavorites(book));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${book.title} removed from favorites'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            context.read<BookBloc>().add(AddToFavorites(book));
                          },
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: book.imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: book.imageUrl,
                                width: 50,
                                height: 75,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  width: 50,
                                  height: 75,
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 50,
                                  height: 75,
                                  color: Colors.grey[200],
                                  child: Icon(Icons.book,
                                      size: 24, color: Colors.grey[400]),
                                ),
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.book,
                                  size: 24, color: Colors.grey[400]),
                            ),
                      title: Text(
                        book.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        book.author,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(book: book),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
