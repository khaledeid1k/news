import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Search extends StatelessWidget {
   Search({super.key});
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var baseCubit = BaseCubit.getInstance(context);

    return BlocConsumer<BaseCubit,BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {return Scaffold(
        appBar: AppBar(),
        body: Column(children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: defaultFormField(
              controller:searchController,
              keyboardType: TextInputType.text,
              validator: (s){if(s?.isEmpty?? true) return "Result Not Found " ; return null;},
              labelText:"Search",
              prefixIcon: Icon(Icons.search),
              onChanged: (textSearch){
                baseCubit.getSearchResult(textSearch: textSearch);
              },


            ),
          ),
          Expanded(
            child: ConditionalBuilder(
              condition: state is! NewsLoadingState,
              fallback: (c) => fallbackByProgress(c),
              builder: (c) => defaultItemNews(context,articles: baseCubit.searchResult ),
            ),
          ),
        ],),
      );},

    );
  }
}
