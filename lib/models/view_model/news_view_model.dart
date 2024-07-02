import 'package:bottom_navigation_bar/models/new_channel_headline_model/new_channel_headline_model.dart';
import 'package:bottom_navigation_bar/repository/news_repository.dart';

import '../new_channel_headline_model/categories_new_model.dart';

class NewsViewModel {
  final _repository = NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadLineApi(String source) async {
    final response = await _repository.fetchNewsChannelHeadLineApi(source);
    return response;
  }
  Future<CategoriesNewsModel> fetchCategoiresNewsApi(String source) async {
    final response = await _repository.fetchCategoiresNewsApi(source);
    return response;
  }
}
