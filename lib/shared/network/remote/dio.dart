import 'package:dio/dio.dart';

class DioHelper{
  static Dio dio=Dio();
  void inti(){
    final options = BaseOptions(
      baseUrl: 'https://newsapi.org/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    dio = Dio(options);
  }
 static Future<Response> getData(
     {required String path, required  Map<String, dynamic>? query}) async {
    return  await DioHelper.dio.request(
      path,
      queryParameters: query,
      options: Options(method: 'GET'),
    );
  }
}