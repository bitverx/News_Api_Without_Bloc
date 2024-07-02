import 'dart:convert';
import 'package:bottom_navigation_bar/models/new_channel_headline_model/new_channel_headline_model.dart';
import 'package:http/http.dart' as http;

import '../models/new_channel_headline_model/categories_new_model.dart';

class NewsRepository {
  Future<CategoriesNewsModel> fetchCategoiresNewsApi(String category) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=0a51f1bf79244558b69f2dff9c2f4084';
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadLineApi(String source) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=0a51f1bf79244558b69f2dff9c2f4084';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    } else {
      throw Exception('Error fetching news');
    }
  }
}
