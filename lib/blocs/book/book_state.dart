import 'package:equatable/equatable.dart';
import '../../models/book.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookSearchLoading extends BookState {}

class BookSearchSuccess extends BookState {
  final List<Book> books;

  const BookSearchSuccess(this.books);

  @override
  List<Object> get props => [books];
}

class BookSearchError extends BookState {
  final String message;

  const BookSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoritesLoading extends BookState {}

class FavoritesLoaded extends BookState {
  final List<Book> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class FavoritesError extends BookState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteStatus extends BookState {
  final bool isFavorite;

  const FavoriteStatus(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}
