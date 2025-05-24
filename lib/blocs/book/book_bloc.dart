import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/book_repository.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;

  BookBloc({required this.repository}) : super(BookInitial()) {
    on<SearchBooks>(_onSearchBooks);
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<CheckFavoriteStatus>(_onCheckFavoriteStatus);
  }

  Future<void> _onSearchBooks(
    SearchBooks event,
    Emitter<BookState> emit,
  ) async {
    emit(BookSearchLoading());
    try {
      final books = await repository.searchBooks(event.query);
      emit(BookSearchSuccess(books));
    } catch (e) {
      emit(BookSearchError(e.toString()));
    }
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<BookState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final favorites = await repository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<BookState> emit,
  ) async {
    try {
      await repository.addToFavorites(event.book);
      add(LoadFavorites());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<BookState> emit,
  ) async {
    try {
      await repository.removeFromFavorites(event.book);
      add(LoadFavorites());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onCheckFavoriteStatus(
    CheckFavoriteStatus event,
    Emitter<BookState> emit,
  ) async {
    try {
      final isFavorite = await repository.isFavorite(event.book);
      emit(FavoriteStatus(isFavorite));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
