import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/remote/dio.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';

class Sports extends StatelessWidget {
  Sports({super.key});

  @override
  Widget build(BuildContext context) {
    var baseCubit = BaseCubit.getInstance(context);
    return BlocConsumer<BaseCubit,BaseStates>(
      listener: (context, state) => {},
      builder:(context, state) =>  ConditionalBuilder(
      condition: state is! NewsLoadingState,
      fallback: (c) => fallbackByProgress(c),
      builder: (c) => defaultItemNews(context,articles: baseCubit.currentList ),
    ),
    );
  }
}
