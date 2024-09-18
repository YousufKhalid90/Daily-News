import 'package:flutter/material.dart';

import '../Data/Models/article_model.dart';
import '../Network/news_service.dart';

class HeadlineProvider with ChangeNotifier {
  final NewsService newsService;
  List<Article> _articles = [];
  bool _isLoading = false;
  String _error = '';

  HeadlineProvider({required this.newsService});

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchHeadlines() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await newsService.fetchNews();
      _articles = response.articles;
    } catch (e) {
      _error = 'Failed to load news: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
