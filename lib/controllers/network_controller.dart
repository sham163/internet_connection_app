import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart';

class NetworkController extends GetxController {
  var isConnected = false.obs; 
  var connectionType = ''.obs; 
  var isVpnActive = false.obs; 
  Timer? vpnStatusTimer; 

  @override
  void onInit() {
    super.onInit();
    checkNetworkStatus();
    updateVpnStatus(); 
  }

  
  void checkNetworkStatus() async {
    
    ConnectivityResult result = await Connectivity().checkConnectivity();
    updateConnectionStatus(result);

    
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });
  }

  
  void updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile) {
      isConnected.value = true;
      connectionType.value = 'Mobile data';
      showSnackBar('Connected', 'You are connected to Mobile Data', true);
    } else if (result == ConnectivityResult.wifi) {
      isConnected.value = true;
      connectionType.value = 'Wi-Fi';
      showSnackBar('Connected', 'You are connected to Wi-Fi', true);
    } else {
      isConnected.value = false;
      connectionType.value = 'None'; 
      showSnackBar('Disconnected', 'You are offline', false);
    }
  }

 
  void updateVpnStatus() {
    vpnStatusTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool vpnActive = await VpnConnectionDetector.isVpnActive();
      isVpnActive.value = vpnActive;
    });
  }

  
  void showSnackBar(String title, String message, bool isConnected) {
  Future.delayed(Duration.zero, () {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 3),
    );
  });
}


  @override
  void onClose() {
    
    vpnStatusTimer?.cancel();
    super.onClose();
  }
}
