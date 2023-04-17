import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bottom_sheets/filter_bottom_sheet.dart';
import 'package:untitled/controllers/search_movie_controller.dart';
import 'package:untitled/utils/app_colors.dart';
import 'package:untitled/utils/app_images.dart';
import 'package:untitled/utils/app_strings.dart';
import 'package:untitled/utils/baseClass.dart';
import 'package:untitled/views/fav_movies/fav_movie_page.dart';
import 'package:untitled/views/movie_details/movie_detail_page.dart';
import 'package:untitled/widgets/form_input.dart';

class HomePage extends StatelessWidget with BaseClass {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  SearchMovieController searchMovieController =
      Get.put(SearchMovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        centerTitle: true,
        title: Text(
          AppStrings.appName,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              removeFocusFromEditText(context: context);
              if (searchMovieController.searchMovieModel == null) {
                showError(title: AppStrings.noData, message:AppStrings.noDataToFilter );
              } else if (searchMovieController
                  .searchMovieModel!.Search!.isEmpty) {
                showError(title: AppStrings.noData, message:AppStrings.noDataToFilter );
              } else {
                FilterBottomSheet.showFilterBottomSheet(
                  context: context,
                  onNameClicked: () {
                    searchMovieController.sortByName();
                  },
                  onYearClicked: () {
                    searchMovieController.sortByYear();
                  },
                  onCancelClicked: () {
                    Get.back();
                  },
                );
              }
            },
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async{
              bool internet = await checkInternet();
              if(internet){
                pushToNextScreen(context: context, destination: FavMoviePage());
              }
              else{
                showError(title: AppStrings.noInternetTitle, message: AppStrings.noInternet);
              }

            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                height: 45,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: FormInput(
                        label: AppStrings.searchMovies,
                        onChanged: () {},
                        focusNode: FocusNode(),
                        hintText: AppStrings.searchMovies,
                        controller: controller,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (controller.text.isEmpty) {
                          showError(
                              title: AppStrings.empty,
                              message: AppStrings.enterKeywords);
                        } else if (controller.text.length < 3) {
                          showError(
                              title: AppStrings.length,
                              message: AppStrings.lengthDesc);
                        } else {
                          try {
                            removeFocusFromEditText(context: context);
                            showCircularDialog(context);
                            await searchMovieController.searchMovie(
                                title: controller.text, type: "movie");
                            popToPreviousScreen(context: context);
                          } catch (e) {
                            popToPreviousScreen(context: context);
                            showError(
                                title: e.toString(), message: e.toString());
                          }
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Search",
                            style: GoogleFonts.roboto(
                                color: AppColors.yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GetBuilder<SearchMovieController>(
                  init: searchMovieController,
                  builder: (value) {
                    return searchMovieController.searchMovieModel == null
                        ? Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Image(
                                  image: AssetImage(AppImages.searchImage),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                                child: Text(
                                  'Explore the library\nSearch for any Movie',
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: searchMovieController
                                    .searchMovieModel?.Search?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          bool isConnected =
                                              await checkInternet();
                                          if (isConnected) {
                                            pushToNextScreen(
                                              context: context,
                                              destination: MovieDetailPage(
                                                movieDetails:
                                                    searchMovieController
                                                        .searchMovieModel!
                                                        .Search!
                                                        .elementAt(index)!,
                                              ),
                                            );
                                          } else {
                                            showError(
                                                title: AppStrings.noInternetTitle,
                                                message:
                                                   AppStrings.noInternet);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: searchMovieController
                                                  .searchMovieModel!.Search!
                                                  .elementAt(index)!
                                                  .Poster!,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress,
                                                    color: AppColors.yellow,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    searchMovieController
                                                        .searchMovieModel!
                                                        .Search!
                                                        .elementAt(index)!
                                                        .Title!,
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    "(${searchMovieController.searchMovieModel!.Search!.elementAt(index)!.Year!})",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
