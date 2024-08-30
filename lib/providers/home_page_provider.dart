import 'package:flutter/material.dart';
import 'package:news_api/models/articles.dart';
import 'package:news_api/repositories/repository_articles.dart';

class ArticleProvider with ChangeNotifier {
  final ArticlesRepository _articleRepository;

  Articles _articlesList = const Articles();
  Articles get articlesList => _articlesList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isHovered = false;

  ArticleProvider(this._articleRepository);

  Future<Articles> getArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articlesList = await _articleRepository.fetchArticles();
      return _articlesList;
    } catch(error) {
      throw Exception(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
