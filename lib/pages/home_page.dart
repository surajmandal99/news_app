import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/cartegory.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/pages/categoryNewsScreen.dart';
import 'package:news_app/pages/newsTile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _loading;
  var newslist;

  void getNews() async {
    News news = News();
    await news.getNews();
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
        drawer: const Drawer(),
        appBar: AppBar(
          actions: [
            Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.search))
          ],
          centerTitle: true,
          title: const Text(
            'DailyNews',
            style: TextStyle(fontSize: 25),
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
                    'Category',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  //Category
                  Container(
                    height: 320,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categorieslist.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CategoryCard(
                            imgUrl:
                                categorieslist.categories[index].imageAssetUrl,
                            categoryName:
                                categorieslist.categories[index].categoryname,
                          ),
                        );
                      },
                    ),
                  ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNewsScreen(
                      category: categoryName,
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Stack(
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
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
