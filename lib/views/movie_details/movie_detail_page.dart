import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/controllers/movie_details_controller.dart';
import 'package:untitled/local_db/fav_movies_list.dart';
import 'package:untitled/models/search_movie_model.dart';
import 'package:untitled/utils/baseClass.dart';

import '../../widgets/detail_widget.dart';

class MovieDetailPage extends StatelessWidget with BaseClass {
  final SearchMovieModelSearch movieDetails;
  final FavMoviesLocalDb _favMoviesLocalDb = Get.put(FavMoviesLocalDb());

  MovieDetailPage({
    Key? key,
    required this.movieDetails,
  }) : super(key: key);
  MovieDetailController controller = Get.put(MovieDetailController());

  @override
  Widget build(BuildContext context) {
    controller.getMovieDetails(
        imdbID: movieDetails.imdbID!,
        title: movieDetails.Title!,
        type: "movie");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: GetBuilder<MovieDetailController>(
              init: controller,
              builder: (value) {
                return controller.movieDetailModel == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber,
                          ),
                        ),
                      )
                    : ListView(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.shade300, BlendMode.screen),
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    controller.movieDetailModel!.Poster!),
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 1.8,
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 15,
                                  child: InkWell(
                                    onTap: () async {
                                      Map<String, dynamic> movieMap = {
                                        "title": movieDetails.Title,
                                        "poster": movieDetails.Poster,
                                        "imdbID": movieDetails.imdbID,
                                        "year": movieDetails.Year,
                                      };

                                      await _favMoviesLocalDb
                                          .addMovieToFav(movieMap);
                                      showSuccess(
                                          title: "Success",
                                          message:
                                              "Movie added to favourite list");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "Add to Fav",
                                        style: GoogleFonts.roboto(
                                            color: Colors.amber),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  bottom: 40,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(controller
                                                .movieDetailModel!.Poster!),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.7,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: 10,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              controller
                                                  .movieDetailModel!.Title!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 2.0,
                              ),
                              child: Text(
                                controller.movieDetailModel!.imdbRating!,
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Center(
                            child: buildRatingStar(int.tryParse(double.tryParse(
                                        controller
                                            .movieDetailModel!.imdbRating!)!
                                    .floor()
                                    .toString())) ??
                                const Text('N/A'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DetailWidget(
                                detail: 'Length',
                                value: controller.movieDetailModel!.Runtime!,
                              ),
                              DetailWidget(
                                detail: 'Language',
                                value: controller.movieDetailModel!.Language!
                                    .split(',')[0],
                              ),
                              DetailWidget(
                                detail: 'Year',
                                value: controller.movieDetailModel!.Year!,
                              ),
                              DetailWidget(
                                detail: 'Country',
                                value: controller.movieDetailModel!.Country!
                                    .split(',')[0],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              'Plot',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 8, bottom: 10),
                            child: Text(
                              controller.movieDetailModel!.Plot!,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              'Genre',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 10),
                            child: Text(
                              controller.movieDetailModel!.Genre!,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 15),
                            child: Text(
                              'Ratings',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'IMDB : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  controller.movieDetailModel!.imdbRating! ==
                                          'N/A'
                                      ? 'No Information'
                                      : controller
                                          .movieDetailModel!.imdbRating!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' ( ${controller.movieDetailModel!.imdbVotes} votes )',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'MetaScore : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.Metascore ==
                                          'N/A'
                                      ? 'Not rated'
                                      : controller.movieDetailModel!.Metascore!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              'Cast',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 10),
                            child: Text(
                              controller.movieDetailModel!.Actors!,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              'Director',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 10),
                            child: Text(
                              controller.movieDetailModel!.Director!,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              'Writer',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 10),
                            child: Text(
                              controller.movieDetailModel!.Writer!,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 15),
                            child: Text(
                              'Detailed Information',
                              style: GoogleFonts.roboto(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 15, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Released : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.Released!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Language : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.Language!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Rated : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.Rated == 'N/A'
                                      ? 'No Information'
                                      : controller.movieDetailModel!.Rated!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Country : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    controller.movieDetailModel!.Country!,
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Awards : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child: Text(
                                  controller.movieDetailModel!.Awards == 'N/A'
                                      ? 'No Information'
                                      : controller.movieDetailModel!.Awards!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'DVD : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.DVD == 'N/A'
                                      ? 'No Information'
                                      : controller.movieDetailModel!.DVD!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Box Office : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.BoxOffice ==
                                          'N/A'
                                      ? 'No Information'
                                      : controller.movieDetailModel!.BoxOffice!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Production : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.Production ==
                                          'N/A'
                                      ? 'No Information'
                                      : controller
                                          .movieDetailModel!.Production!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Website : ',
                                  style: GoogleFonts.roboto(
                                      color: Colors.amber,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.movieDetailModel!.Website == 'N/A'
                                      ? 'No Information'
                                      : controller.movieDetailModel!.Website!,
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      );
              })),
    );
  }

  Widget buildRatingStar(int? value) {
    List<Widget> stars = [];
    Color color = Colors.yellow.shade700;
    if (value == 10) {
      for (int i = 0; i < 5; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
    } else if (value == 9) {
      for (int i = 0; i < 4; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
    } else if (value == 8) {
      for (int i = 0; i < 4; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 7) {
      for (int i = 0; i < 3; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 6) {
      for (int i = 0; i < 3; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 5) {
      for (int i = 0; i < 2; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 4) {
      for (int i = 0; i < 2; i++) {
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      }
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 3) {
      stars.add(Icon(
        Icons.star,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 2) {
      stars.add(Icon(
        Icons.star,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else {
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
