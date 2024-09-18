import 'dart:convert';

import '../Data/Models/newsresponse_model.dart';
import 'api_client.dart';

class NewsService {
  final ApiClient apiClient;

  NewsService({required this.apiClient});

  Future<NewsResponse> fetchNews() async {
    final response = await apiClient.get(
        '/top-headlines?sources=bbc-news&apiKey=eb3c001f97734371a501c989523ae424'); // Replace with your actual endpoint

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<NewsResponse> fetchCategoryNews(String category) async {
    final response = await apiClient
        .get('/everything?q=$category&apiKey=eb3c001f97734371a501c989523ae424');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsResponse.fromJson(data);
    } else {
      throw Exception('Failed to load news for category: $category');
    }
  }

  // Add other API methods as needed
}
