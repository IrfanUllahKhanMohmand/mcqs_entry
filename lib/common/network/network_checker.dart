import 'dart:ui';
import 'package:dio/dio.dart';

class NetworkChecker{
  VoidCallback? onComplete;
  VoidCallback? onError;

  NetworkChecker({this.onComplete, this.onError});

  void doRequest() async{
    try {
      Dio dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 5); // Set a timeout of 5 seconds
      Response response = await dio.get('https://www.google.com');
      if(response.statusCode == 200){
        onComplete!();
      }
    } on DioError catch (e) {
      onError!();
    } catch (e) {
      onError!();
    }
  }
}