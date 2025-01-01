import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleViewController extends GetxController{
  RxBool isGridView = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadViewPreference();
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
    saveViewPreference();
  }

  void saveViewPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGridView', isGridView.value);
  }

  void loadViewPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isGridView.value = prefs.getBool('isGridView') ?? false;
  }
}