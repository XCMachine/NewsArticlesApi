import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/constants.dart';
import '../models/articles.dart';

class ApiService {
  final _url = Uri.parse('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${Constants.apiKey}');

  Future<Articles> fetchArticles() async {
    var response = await http.get(_url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      debugPrint('Status code success: ${response.statusCode}');
      return Articles.fromJson(data);
    } else {
      throw Exception('Status code error: ${response.statusCode}');
    }
  }
}
