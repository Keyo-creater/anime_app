import 'package:anime_app/Models/For_Genre/genre_list_response.dart';
import 'package:anime_app/router/router.gr.dart';
import 'package:anime_app/service/api_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  final PagingController<int, GenreList> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // ApiService().getGenreList(0).then((value) => print(value.toString()));

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await ApiService().getGenreList(pageKey);

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
      body: PagedGridView<int, GenreList>(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
        ),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<GenreList>(
            itemBuilder: (context, genereList, index) {
          return InkWell(
            onTap: () {
              // print("You tapped on ${genereList.links.self}");
              AutoRouter.of(context).push(GenreDetailRoute(
                  clickedUrl: genereList.links.self,
                  clickedGenreName: genereList.attributes.name));
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Center(
                child: Text(
                  genereList.attributes.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 0.65),
                  ),
                ),
              ),
              color: Colors.orange,
            ),
          );
        }),
      ),
    );
  }
}

// body: PagedListView<int, GenreList>(
//   pagingController: _pagingController,
//   builderDelegate: PagedChildBuilderDelegate<GenreList>(
//       itemBuilder: (context, genereList, index) {
//     if (index % 3 == 0)
//       return Card(
//         child: Text(genereList.id + "-" + genereList.attributes.name),
//       );
//       else return Card(
//         child: Text(genereList.id),
//       );
//     // return Card(
//     //   child: Text(genereList.attributes.name),
//     // );
//   }),
// ),