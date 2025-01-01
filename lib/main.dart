import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_tasks/Placement%20Task%20Day-1-%20Todo%20app/screens/home_screen.dart';

import 'Placement Task Day-1- Todo app/controller/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(),
    );
  }
}

