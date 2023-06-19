import 'package:bloc/bloc.dart';
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

class BaseCubit extends Cubit<BaseStates> {
  BaseCubit() : super(InitState());

  static BaseCubit getInstance(context) => BlocProvider.of(context);
  int currentIndex = 0;
  var logger = Logger();

  List<BottomNavigationBarItem> bottomNavigationList= const[
     BottomNavigationBarItem(icon: Icon(Icons.sports), label: sports),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: business),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: science),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: settings),
  ];

  List<Widget> screens= const[
     Sports(),
    Business(),
    Science(),
    Settings()
  ];
  void changeCurrentIndex(currentIndex) {
    this.currentIndex = currentIndex;
    emit(CurrentIndexState());
  }





}
