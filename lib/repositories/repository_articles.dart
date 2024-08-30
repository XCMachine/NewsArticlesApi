import 'package:news_api/http/http.dart';
import 'package:news_api/models/articles.dart';

class ArticlesRepository {
  final ApiService _apiService;

  const ArticlesRepository(this._apiService);

  Future<Articles> fetchArticles() async {
    try {
      return await _apiService.fetchArticles();
    } catch(error) {
      throw Exception(error);
    }
  }
}