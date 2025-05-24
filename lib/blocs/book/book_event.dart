import 'package:equatable/equatable.dart';
import '../../models/book.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class SearchBooks extends BookEvent {
  final String query;

  const SearchBooks(this.query);

  @override
  List<Object> get props => [query];
}

class LoadFavorites extends BookEvent {}

class AddToFavorites extends BookEvent {
  final Book book;

  const AddToFavorites(this.book);

  @override
  List<Object> get props => [book];
}

class RemoveFromFavorites extends BookEvent {
  final Book book;

  const RemoveFromFavorites(this.book);

  @override
  List<Object> get props => [book];
}

class CheckFavoriteStatus extends BookEvent {
  final Book book;

  const CheckFavoriteStatus(this.book);

  @override
  List<Object> get props => [book];
}
