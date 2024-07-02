import 'package:bottom_navigation_bar/models/new_channel_headline_model/categories_new_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../new_channel_headline_model/new_channel_headline_model.dart';
import '../view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget{
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  String categoryName = 'General';
  List<String> categoriesList=[
    'General',
    'Entertainment',
    'health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: (){
                        categoryName = categoriesList[index];
                        setState(() {

                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName==categoriesList[index]? Colors.blue:Colors.grey,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                              child: Text(categoriesList[index].toString(),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white
                              ),)),
                        ),
                      ),
                    ),
                  );
                  }),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoiresNewsApi(categoryName),
                builder: (BuildContext context, snapshot) {
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
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
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
                                  height: height*.25,
                                  width: width*.35,
                                  placeholder: (context, url) => SpinKitFadingCircle(
                                    size: 50,
                                    color: Colors.amber,
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Expanded(child: Container(
                                height: height*.18,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!.articles![index].title.toString(),
                                        style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700) ,),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text(snapshot.data!.articles![index].source!.name.toString()),
                                          SizedBox(width: 15),
                                          Text(format.format(datetime)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}