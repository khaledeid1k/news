import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/network/remote/dio.dart';

import 'layout/homeNews.dart';

void main() {
  DioHelper().inti();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black,fontSize:30.0,fontWeight: FontWeight.bold),
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.red,
            statusBarBrightness: Brightness.dark
          ),),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type:BottomNavigationBarType.fixed,
            selectedItemColor: Colors.cyan,


          ),
        ),
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Home()));
  }

}

