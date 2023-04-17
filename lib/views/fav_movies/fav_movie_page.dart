import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/movie_details_controller.dart';
import '../../local_db/fav_movies_list.dart';
import '../../utils/app_colors.dart';

class FavMoviePage extends StatelessWidget {
  FavMoviePage({Key? key}) : super(key: key);
  final FavMoviesLocalDb _favMoviesLocalDb = Get.put(FavMoviesLocalDb());

  @override
  Widget build(BuildContext context) {
    _favMoviesLocalDb.getFavMoviesList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        centerTitle: true,
        title: Text(
          "Favourite Movies",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GetBuilder<FavMoviesLocalDb>(
          init: _favMoviesLocalDb,
          builder: (snapshot) {
            return _favMoviesLocalDb.movieList.isEmpty
                ? const Center(child: Text("No Fav. Movies Found"))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount: _favMoviesLocalDb.movieList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: _favMoviesLocalDb.movieList
                                      .elementAt(index)["poster"],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: AppColors.yellow,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        _favMoviesLocalDb.movieList
                                            .elementAt(index)["title"],
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "(${_favMoviesLocalDb.movieList.elementAt(index)["year"]})",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await _favMoviesLocalDb.deleteInfo(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          );
                        }),
                  );
          }),
    );
  }
}
