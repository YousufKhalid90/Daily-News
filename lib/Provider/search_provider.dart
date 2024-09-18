import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  //final SearchService _searchService = SearchService();
  String _searchResult = '';
  bool _isLoading = false;

  String get searchResult => _searchResult;
  bool get isLoading => _isLoading;

  Future<void> performSearch(String query) async {
    _isLoading = true;
    notifyListeners();

    //_searchResult = await _searchService.search(query);

    _isLoading = false;
    notifyListeners();
  }
}
