import 'package:flutter/material.dart';

import '../Data/Models/article_model.dart';
import '../Network/news_service.dart';

// Assume you have a NetworkService for API calls

class CategoryProvider with ChangeNotifier {
  String _selectedCategory = 'Trending';
  final NewsService newsService;
  List<Article> _articles = [];
  bool _isLoading = false;
  String _error = '';
  String get selectedCategory => _selectedCategory;
  CategoryProvider({required this.newsService});

  List<Article> get articles => _articles;

  void selectCategory(String category) {
    _selectedCategory = category;
    print('fetching categorydata');
    _fetchItemsForCategory(category);
    notifyListeners();
  }

  Future<void> _fetchItemsForCategory(category) async {
    print('api call is being made');
    _isLoading = true;
    notifyListeners();

    try {
      print('inside try api');
      final response = await newsService.fetchCategoryNews(category);
      _articles = response.articles;
      print('_articles');
    } catch (e) {
      print('error');
      _error = 'Failed to load news: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
