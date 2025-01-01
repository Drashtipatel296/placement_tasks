import 'package:get/get.dart';
import '../helper/api_helper.dart';
import '../model/todo_model.dart';

class ApiController extends GetxController {
  var apiHelper = ApiHelper();
  var todos = <TodoModel>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApi();
  }

  Future<void> fetchApi() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final data = await apiHelper.fetchData();
      todos.value = data.map((json) => TodoModel.fromJson(json)).toList();
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
