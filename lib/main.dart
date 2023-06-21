import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/components/constants.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cach_helper.dart';
import 'package:news/shared/network/remote/dio.dart';

import 'layout/homeNews.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper().inti();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.inti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider<BaseCubit>(
      create: (context) => BaseCubit()..getNews(category: "sports")..changeTheme(),
      child: BlocConsumer<BaseCubit, BaseStates>(
        listener: (context, state) => {},
        builder: (context, state) =>
            MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.cyan,
                  appBarTheme: const AppBarTheme(
                    titleSpacing: 20.0,
                    backgroundColor: Colors.white,
                    actionsIconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.red,
                        statusBarBrightness: Brightness.dark
                    ),),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.cyan,
                      backgroundColor: Colors.white,
                      unselectedItemColor: Colors.grey


                  ),
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.black
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  primarySwatch: Colors.cyan,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.cyan,
                      backgroundColor: HexColor('333739'),
                      unselectedItemColor: Colors.grey


                  ),
                  scaffoldBackgroundColor: HexColor('333739'),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,

                    backgroundColor: HexColor('333739'),
                    actionsIconTheme:
                    IconThemeData(color: Colors.white),
                    titleTextStyle: TextStyle(
                        color: Colors.white, fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarBrightness: Brightness.light
                    ),),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                  ),
                ),
                themeMode: BaseCubit.getInstance(context).themeMode,


                home: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Home())),
      ),
    );

  }

}

