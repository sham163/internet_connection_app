import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_app/views/home_view.dart';
import 'package:internet_connection_app/controllers/network_controller.dart';

void main() {
  // Initialize the NetworkController
  Get.put(NetworkController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internet Connection App',
      home: HomeView(),
    );
  }
}
