import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Home extends StatelessWidget {
//https://newsapi.org/
// v2/top-headlines
// ?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BaseCubit()..getNews(category: "sports"),
      child: BlocConsumer<BaseCubit, BaseStates>(
        builder: (BuildContext context, BaseStates state) {
          var baseCubit = BaseCubit.getInstance(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text("News"),
              actions: [
                IconButton(onPressed: (){},
                    icon: const Icon(Icons.search),)
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: baseCubit.currentIndex,
              onTap: (value) {
                baseCubit.changeCurrentIndex(value);
              },
              items: baseCubit.bottomNavigationList
            ),
            body: baseCubit.screens[baseCubit.currentIndex],
          );
        },
        listener: (context, state) {},
      ),
    );
  }



}


