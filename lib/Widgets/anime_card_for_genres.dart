import 'package:flutter/material.dart';

class AnimeCardForGenres extends StatelessWidget {
  const AnimeCardForGenres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("hi");
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 140, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: 117,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      "Anime Title Here",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    width: MediaQuery.of(context).size.width - 160,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        color: Color.fromRGBO(255, 195, 0, 1),
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "83.1",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Text(
                      "Adventure fiction, Dark fantasy, Martial Arts, Action",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.65),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 160,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 115,
            height: 156,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(3, 0),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/sample_poster.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
