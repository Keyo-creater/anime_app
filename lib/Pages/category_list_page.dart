import 'package:anime_app/Models/For_Category/category_list_response.dart';
import 'package:anime_app/Widgets/drawer_list.dart';
import 'package:anime_app/router/router.gr.dart';
import 'package:anime_app/service/api_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final PagingController<int, CategoryList> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // ApiService().getCategoryList(0).then((value) => print(value.toString()));

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await ApiService().getCategoryList(pageKey);

      final bool isLastPage = response.meta.count <= pageKey;
      // print("count: ${response.meta.count}");
      // print("Is last : $isLastPage");
      // print("pageKey : $pageKey");
      if (isLastPage) {
        _pagingController.appendLastPage(response.data);
      } else {
        final int nextPageKey = pageKey + 10;
        _pagingController.appendPage(response.data, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres'),
      ),
      drawer: Drawer(
        child: DrawerList(),
      ),
      body: PagedGridView<int, CategoryList>(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
        ),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CategoryList>(
            itemBuilder: (context, categoryList, index) {
          return InkWell(
            onTap: () {
              // print(
              // "You tapped on ${categoryList.relationships.anime.links.related}");
              AutoRouter.of(context).push(CategoryRelatedAnimeRoute(
                  clickedUrl: categoryList.relationships.anime.links.related,
                  clickedGenreName: categoryList.attributes.title));
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Center(
                child: Text(
                  categoryList.attributes.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 0.65),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}