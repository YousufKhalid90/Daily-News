import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client client;

  ApiClient({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await client.get(url);
    return response;
  }

  // You can add other HTTP methods (POST, PUT, DELETE) here if needed
}
