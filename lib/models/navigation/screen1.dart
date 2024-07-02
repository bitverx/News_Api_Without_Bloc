import 'package:bottom_navigation_bar/models/navigation/cateogires_screen.dart';
import 'package:bottom_navigation_bar/models/new_channel_headline_model/new_channel_headline_model.dart';
import 'package:bottom_navigation_bar/models/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../new_channel_headline_model/categories_new_model.dart';

class Screen1 extends StatefulWidget {
  @override
  State<Screen1> createState() => _Screen1State();
}

enum FilterList { bbcNew, aryNews, arstechnica, reuters, cnn, alJazeera }

class _Screen1State extends State<Screen1> {
  final NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMeu;
  final format = DateFormat('MMM dd, yyyy');
  String name = 'bbc-news';
  String categoryName = 'general'; // Add this line if categoryName is not already defined
  late Future<NewsChannelHeadlineModel> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = newsViewModel.fetchNewsChannelHeadLineApi(name);
  }

  void _onMenuSelected(FilterList item) {
    setState(() {
      selectedMeu = item;
      switch (item) {
        case FilterList.bbcNew:
          name = 'bbc-news';
          break;
        case FilterList.aryNews:
          name = 'ary-news';
          break;
        case FilterList.arstechnica:
          name = 'ars-technica';
          break;
        case FilterList.reuters:
          name = 'reuters';
          break;
        case FilterList.cnn:
          name = 'cnn';
          break;
        case FilterList.alJazeera:
          name = 'al-jazeera-english';
          break;
      }
      futureNews = newsViewModel.fetchNewsChannelHeadLineApi(name); // Update the futureNews here
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'images/menu.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMeu,
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNew,
                child: Text('BBC News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text('ARY News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.arstechnica,
                child: Text('arstechnica'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.reuters,
                child: Text('Reuters'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text('CNN'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: Text('Al Jazeera'),
              ),
            ],
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<NewsChannelHeadlineModel>(
              future: futureNews, // Use the futureNews variable here
              builder: (BuildContext context, AsyncSnapshot<NewsChannelHeadlineModel> snapshot) {
                print('News API called for $name'); // Debug print
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.amber,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data?.articles == null) {
                  return Center(
                    child: Text('No data available'),
                  );
                } else {
                  print('News data received: ${snapshot.data!.articles!.length} articles'); // Debug print
                  return Container(
                    height: height * 0.6,
                    child: ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return SizedBox(
                          child: Stack(
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * .02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SpinKitFadingCircle(
                                      size: 50,
                                      color: Colors.amber,
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250,
                                left: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: height * .22,
                                    width: width * 0.8, // Added width to the Card
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString()),
                                              SizedBox(width: 50),
                                              Text(format.format(datetime)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoiresNewsApi(categoryName), // Use categoryName for categories
              builder: (BuildContext context, snapshot) {
                print('Categories API called for $categoryName'); // Debug print
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.amber,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data?.articles == null) {
                  return Center(
                    child: Text('No data available'),
                  );
                } else {
                  print('Categories data received: ${snapshot.data!.articles!.length} articles'); // Debug print
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage ?? '',
                                  fit: BoxFit.cover,
                                  height: height * .25,
                                  width: width * .35,
                                  placeholder: (context, url) => SpinKitFadingCircle(
                                    size: 50,
                                    color: Colors.amber,
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * .18,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title.toString(),
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString()),
                                            SizedBox(width: 1),
                                            Text(format.format(datetime)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
