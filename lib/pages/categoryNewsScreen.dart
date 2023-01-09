import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/pages/newsTile.dart';

class CategoryNewsScreen extends StatefulWidget {
  final String newsCategory;
  final String category;

  const CategoryNewsScreen(
      {required this.newsCategory, required this.category});
  @override
  // ignore: library_private_types_in_public_api
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  late bool _loading;
  var newslist;

  void getNews() async {
    CategoryNews news = CategoryNews();
    await news.getCategoryNews(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _loading = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.search))
          ],
          centerTitle: true,
          title: Text(
            widget.category,
            style: const TextStyle(fontSize: 25),
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Latest News',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  //Newslist
                  Container(
                    padding: const EdgeInsets.only(top: 1),
                    child: ListView.builder(
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewsTile(
                              articleUrl: newslist[index].articleUrl,
                              title: newslist[index].title,
                              subtitle: newslist[index].description,
                              imgUrl: newslist[index].imgUrl,
                            ));
                      },
                    ),
                  ),
                ],
              ));
  }
}

class CategoryCard extends StatelessWidget {
  final String imgUrl, categoryName;

  const CategoryCard({required this.imgUrl, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            height: 300,
            width: 180,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 300,
          width: 180,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          child: Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
