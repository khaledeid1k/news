import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:news/modules/search.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BaseCubit, BaseStates>(
      builder: (BuildContext context, BaseStates state) {
        var baseCubit = BaseCubit.getInstance(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text("News"),
            actions: [
              IconButton(onPressed: (){
                navigate(context: context,widget: Search());
              },
                  icon: const Icon(Icons.search),),
              IconButton(
                onPressed: (){
                baseCubit.changeTheme();
              },
                  icon: const Icon(Icons.brightness_4),),
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
    );
  }



}


