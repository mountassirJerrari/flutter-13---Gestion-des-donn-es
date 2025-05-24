import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/book/book_bloc.dart';
import '../blocs/book/book_event.dart';
import '../blocs/book/book_state.dart';
import '../models/book.dart';
import 'detailpage.dart';
import 'favoritespage.dart';

class HomePage extends StatelessWidget {
  final _searchController = TextEditingController();

  void _searchBooks(BuildContext context) {
    if (_searchController.text.isEmpty) return;
    context.read<BookBloc>().add(SearchBooks(_searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search books...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    onSubmitted: (_) => _searchBooks(context),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _searchBooks(context),
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookSearchLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                
                if (state is BookSearchError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          'Error: ${state.message}',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                
                if (state is BookSearchSuccess) {
                  if (state.books.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No books found',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      final book = state.books[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(book: book),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: book.imageUrl.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: book.imageUrl,
                                          width: 80,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(
                                            width: 80,
                                            height: 120,
                                            color: Colors.grey[200],
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                width: 80,
                                                height: 120,
                                                color: Colors.grey[200],
                                                child: Icon(
                                                  Icons.book,
                                                  size: 40,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                        )
                                      : Container(
                                          width: 80,
                                          height: 120,
                                          color: Colors.grey[200],
                                          child: Icon(
                                            Icons.book,
                                            size: 40,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        book.author,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.grey[600],
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Search for books to get started',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
