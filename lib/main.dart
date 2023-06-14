import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mcqs_entry/global.dart';
import 'package:mcqs_entry/pages/data_entry/data_entry_page.dart';
import 'package:mcqs_entry/pages/data_entry/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await Global.init();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataEntryProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false, home: DataEntryPage());
      },
    );
  }
}
