
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controllers/movie_details_controller.dart';
import 'package:untitled/models/search_movie_model.dart';

import '../../widgets/detail_widget.dart';

class MovieDetailPage extends StatelessWidget {
  SearchMovieModelSearch movieDetails;

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
      body: SafeArea(
          child: GetBuilder<MovieDetailController>(
              init: controller,
              builder: (value) {
                return controller.movieDetailModel == null
                    ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black,
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
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  controller.movieDetailModel!.Title!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
                              color: Colors.black87),
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
                      height: 8,
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
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Storyline',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 10),
                      child: Text(controller.movieDetailModel!.Plot!),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Genre',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 10),
                      child: Text(controller.movieDetailModel!.Genre!),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 15),
                      child: Text(
                        'Ratings',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('IMDB : '),
                          Text(controller.movieDetailModel!.imdbRating! ==
                              'N/A'
                              ? 'No Information'
                              : controller.movieDetailModel!.imdbRating!),
                          Text(
                              ' ( ${controller.movieDetailModel!.imdbVotes} votes )'),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('MetaScore : '),
                          Text(controller.movieDetailModel!.Metascore ==
                              'N/A'
                              ? 'Not rated'
                              : controller.movieDetailModel!.Metascore!)
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Cast',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 10),
                      child: Text(controller.movieDetailModel!.Actors!),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Director',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 10),
                      child: Text(controller.movieDetailModel!.Director!),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Writer',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 10),
                      child: Text(controller.movieDetailModel!.Writer!),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 15),
                      child: Text(
                        'Detailed Information',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Released : '),
                          Text(controller.movieDetailModel!.Released!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Language : '),
                          Text(controller.movieDetailModel!.Language!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Rated : '),
                          Text(controller.movieDetailModel!.Rated == 'N/A'
                              ? 'No Information'
                              : controller.movieDetailModel!.Rated!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Country : '),
                          Text(controller.movieDetailModel!.Country!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Awards : '),
                          Expanded(
                              child: Text(controller
                                  .movieDetailModel!.Awards ==
                                  'N/A'
                                  ? 'No Information'
                                  : controller.movieDetailModel!.Awards!))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('DVD : '),
                          Text(controller.movieDetailModel!.DVD == 'N/A'
                              ? 'No Information'
                              : controller.movieDetailModel!.DVD!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Box Office : '),
                          Text(controller.movieDetailModel!.BoxOffice ==
                              'N/A'
                              ? 'No Information'
                              : controller.movieDetailModel!.BoxOffice!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Production : '),
                          Text(controller.movieDetailModel!.Production ==
                              'N/A'
                              ? 'No Information'
                              : controller.movieDetailModel!.Production!)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Website : '),
                          Text(controller.movieDetailModel!.Website ==
                              'N/A'
                              ? 'No Information'
                              : controller.movieDetailModel!.Website!)
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
