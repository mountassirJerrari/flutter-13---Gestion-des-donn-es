import '../models/book.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class BookRepository {
  final ApiService _apiService;
  final DbService _dbService;

  BookRepository({
    ApiService? apiService,
    DbService? dbService,
  })  : _apiService = apiService ?? ApiService(),
        _dbService = dbService ?? DbService();

  Future<List<Book>> searchBooks(String query) async {
    return await _apiService.searchBooks(query);
  }

  Future<List<Book>> getFavorites() async {
    return await _dbService.getFavorites();
  }

  Future<void> addToFavorites(Book book) async {
    await _dbService.addToFavorites(book);
  }

  Future<void> removeFromFavorites(Book book) async {
    await _dbService.removeFromFavorites(book);
  }

  Future<bool> isFavorite(Book book) async {
    return await _dbService.isFavorite(book);
  }
}
