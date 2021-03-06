import 'package:anime_app/Models/For_Anime_Detail/detail_response.dart';
import 'package:anime_app/Widgets/anime_detail.dart';
import 'package:anime_app/service/api_service.dart';
import 'package:anime_app/temp_data.dart';
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  final String clickedUrl;
  const AnimeDetailPage({Key? key, required this.clickedUrl}) : super(key: key);

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<AnimeDetailResponse>(
            future: ApiService().getAnimeDetail(widget.clickedUrl),
            builder: (context, snapshot) {
              String coverImg = "N/A";
              String rating = "N/A";
              String description = "N/A";
              String startDate = "N/A";
              String endDate = "N/A";
              String nextRelease = "N/A";
              String popularityRank = "N/A";
              String ratingRank = "N/A";
              String ageRatingGuide = "N/A";
              String episodeCount = "N/A";
              String episodeLength = "N/A";
              String title = "N/A";
              String statue = "N/A";
              String youtubeVideoId = "N/A";

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(
                    child: const CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    if (snapshot.data!.data.attributes.coverImage != null)
                      coverImg =
                          snapshot.data!.data.attributes.coverImage!.original;
                    if (snapshot.data!.data.attributes.description != null)
                      description = snapshot.data!.data.attributes.description!;
                    if (snapshot.data!.data.attributes.averageRating != null)
                      rating = snapshot.data!.data.attributes.averageRating!;
                    if (snapshot.data!.data.attributes.startDate != null)
                      startDate = snapshot.data!.data.attributes.startDate!;
                    if (snapshot.data!.data.attributes.endDate != null)
                      endDate = snapshot.data!.data.attributes.endDate!;
                    if (snapshot.data!.data.attributes.nextRelease != null)
                      nextRelease = snapshot.data!.data.attributes.nextRelease!;
                    if (snapshot.data!.data.attributes.popularityRank != null)
                      popularityRank = snapshot
                          .data!.data.attributes.popularityRank
                          .toString();
                    if (snapshot.data!.data.attributes.ratingRank != null)
                      ratingRank =
                          snapshot.data!.data.attributes.ratingRank.toString();
                    if (snapshot.data!.data.attributes.ageRatingGuide != null)
                      ageRatingGuide =
                          snapshot.data!.data.attributes.ageRatingGuide!;
                    if (snapshot.data!.data.attributes.episodeCount != null)
                      episodeCount = snapshot.data!.data.attributes.episodeCount
                          .toString();
                    if (snapshot.data!.data.attributes.episodeLength != null)
                      episodeLength = snapshot
                          .data!.data.attributes.episodeLength
                          .toString();
                    if (snapshot.data!.data.attributes.canonicalTitle != null)
                      title = snapshot.data!.data.attributes.canonicalTitle
                          .toString();
                    if (snapshot.data!.data.attributes.youtubeVideoId != null)
                      youtubeVideoId =
                          snapshot.data!.data.attributes.youtubeVideoId!;

                    if (snapshot.data!.data.attributes.status != null)
                      statue = snapshot.data!.data.attributes.status.toString();

                    // Add Anime_Cover_Image to temp variable for further use
                    animeBackdropUrl = coverImg;

                    return AnimeDetail(
                      animeId: snapshot.data!.data.id,
                      coverImageUrl: coverImg,
                      rating: rating,
                      overview: description,
                      animeTitle: title,
                      categoryUrl: snapshot
                          .data!.data.relationships.categories.links.related,
                      startDate: startDate,
                      endDate: endDate,
                      nextRelease: nextRelease,
                      popularityRank: popularityRank,
                      ratingRank: ratingRank,
                      ageRatingGuide: ageRatingGuide,
                      status: statue,
                      episodeCount: episodeCount,
                      episodeLength: episodeLength,
                      youtubeVideoId: youtubeVideoId,
                      self: snapshot.data!.data.links.self,
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
