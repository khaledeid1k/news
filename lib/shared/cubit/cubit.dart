import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news/modules/business.dart';
import 'package:news/modules/science.dart';
import 'package:news/modules/settings.dart';
import 'package:news/shared/cubit/states.dart';

import '../../modules/sports.dart';
import '../components/constants.dart';
import '../network/local/cach_helper.dart';
import '../network/remote/dio.dart';
//https://newsapi.org/v2/everything?q=lol&from=2023-06-20&to=2023-06-20&sortBy=popularity&apiKey=bf401f10eb4a417fa384e36cbb83b2a1
class BaseCubit extends Cubit<BaseStates> {
  BaseCubit() : super(InitState()){
    themeMode = (CacheHelper().readTheme()
        == "ThemeMode.dark")
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  static BaseCubit getInstance(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<dynamic> sportsList = [];
  List<dynamic> businessList = [];
  List<dynamic> scienceList = [];
  List<dynamic> currentList = [];
  List<dynamic> searchResult = [];
   late ThemeMode themeMode=ThemeMode.light;

  List<Widget> screens = [Sports(), Business(), Science(), Settings()];
  List<BottomNavigationBarItem> bottomNavigationList = const [
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: sports),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: business),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: science),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: settings),
  ];

  void changeCurrentIndex(currentIndex) {
    this.currentIndex = currentIndex;
    if (currentIndex == 0) {
      getNews(category: "sports");
    } else if (currentIndex == 1) {
      getNews(category: "business");
    } else {
      getNews(category: "science");
    }
    emit(CurrentIndexState());
  }

  void changeTheme() {
    themeMode = (themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    CacheHelper().saveTheme(themeMode.toString()).then((value) {
      emit(ChangeThemeState());

    });
  }

  void getNews({required String category} ) {
    Map<String, dynamic> query = {};
    if (!['science', 'business', 'sports'].contains(category)) {
      emit(NewsErrorState());
      return;
    }
    bool isListEmpty = false;

    if (category == 'science') {
      isListEmpty = scienceList.isEmpty;
      currentList = scienceList;
    } else if (category == 'business') {
      isListEmpty = businessList.isEmpty;
      currentList = businessList;
    } else if (category == 'sports') {
      isListEmpty = sportsList.isEmpty;
      currentList = sportsList;
    }
    if (isListEmpty) {
      logger.d("${sportsList.length}  ${businessList.length}    ${scienceList.length}");
      emit(NewsLoadingState());
      query['country'] = 'eg';
      query['category'] = category;
      query['apiKey'] = 'bf401f10eb4a417fa384e36cbb83b2a1';

      DioHelper.getData(path: "v2/top-headlines", query: query).then((value) {
        currentList.addAll(value.data["articles"]);
        emit(NewsSuccessState());
      }).catchError((onError) {
        emit(NewsErrorState());
        logger.d(onError.toString());
      });
    } else {
      logger.d("${sportsList.length}  ${businessList.length} ${scienceList.length}");

      logger.d("isNotListEmpty");

      emit(NewsSuccessState());
    }
  }
  void getSearchResult({required String textSearch} ) {
    Map<String, dynamic> query = {};
      emit(NewsLoadingState());
      query['q'] = textSearch;
      query['from'] = '2023-06-21';
      query['to'] = '2023-06-21';
      query['sortBy'] = 'popularity';
      query['apiKey'] = 'bf401f10eb4a417fa384e36cbb83b2a1';

      DioHelper.getData(path: "v2/everything", query: query).then((value) {
        searchResult.addAll(value.data["articles"]);
        logger.d(value.data["articles"].toString());
        emit(NewsSuccessState());
      }).catchError((onError) {
        emit(NewsErrorState());
        logger.d(onError.toString());
      });


  }


}
