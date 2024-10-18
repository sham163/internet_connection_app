import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_app/controllers/network_controller.dart';
import 'second_view.dart';

class HomeView extends StatelessWidget {
  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  networkController.isConnected.value
                      ? "You are connected to ${networkController.connectionType.value}"
                      : "You are offline",
                  style: const TextStyle(fontSize: 18),
                )),
            Obx(() => Text(
                networkController.isVpnActive.value
                ? "VPN is Active"
                : "VPN is Inactive",
                style: const TextStyle(color: Colors.red)
               )
            ), 
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.to(() => SecondView()),
              child: const Text("Go to Second Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
