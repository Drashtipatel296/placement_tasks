import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_tasks/Placement%20Task%20Day-1-%20Todo%20app/controller/save_todo_controller.dart';
import 'package:placement_tasks/Placement%20Task%20Day-1-%20Todo%20app/screens/save_todos.dart';
import '../controller/api_controller.dart';
import '../controller/toggle_view.dart';
import '../controller/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiController apiController = Get.put(ApiController());
    final ToggleViewController toggleViewController = Get.put(ToggleViewController());
    final ThemeController themeController = Get.put(ThemeController());
    final SaveTodoController saveTodoController = Get.put(SaveTodoController());

    return Obx(() {
      final isDarkTheme = themeController.isDarkTheme.value;
      return Scaffold(
        backgroundColor: isDarkTheme ? Colors.black38 : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkTheme ? Colors.black : Colors.purple.shade800,
          title: const Text(
            'Todos',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                themeController.toggleTheme();
              },
              icon: Obx(
                () => Icon(themeController.isDarkTheme.value
                    ? Icons.brightness_2
                    : Icons.light_mode,color: Colors.white,),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(SaveTodoScreen());
              },
              icon: Icon(Icons.favorite_border_outlined,color: Colors.white,),
            ),
            IconButton(
              onPressed: () {
                toggleViewController.toggleView();
              },
              icon: Obx(
                () => Icon(toggleViewController.isGridView.value
                    ? Icons.list
                    : Icons.grid_view,color: Colors.white,),
              ),
            ),
          ],
        ),
        body: Obx(() {
          if (apiController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (apiController.hasError.value) {
            return const Center(child: Text("Failed to load data."));
          } else {
            return toggleViewController.isGridView.value
                ? buildGridView(apiController, saveTodoController,themeController)
                : buildListView(apiController,saveTodoController,themeController);
          }
        }),
      );
    });
  }

  GridView buildGridView(ApiController apiController, SaveTodoController saveTodoController, ThemeController themeController) {
    return GridView.builder(
      itemCount: apiController.todos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final todo = apiController.todos[index];
        return Card(
          color: todo.completed ? Colors.green[100] : Colors.red[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(todo.id.toString(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Text(todo.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Row(
                  children: [
                    Icon(todo.completed ? Icons.check_circle : Icons.cancel),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      todo.completed ? 'Completed' : 'Pending',
                      style: todo.completed
                          ? TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800)
                          : const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    Spacer(),
                    Obx(() => IconButton(
                      icon: Icon(
                        saveTodoController.saveTodo.any(
                                (item) => item.id == todo.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: themeController.isDarkTheme.value
                            ? Colors.black
                            : Colors.purple.shade800,
                      ),
                      onPressed: () {
                        saveTodoController.toggleBookmark(todo);
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView buildListView(ApiController apiController, SaveTodoController saveTodoController, ThemeController themeController) {
    return ListView.builder(
      itemCount: apiController.todos.length,
      itemBuilder: (context, index) {
        final todo = apiController.todos[index];
        return Card(
          color: todo.completed ? Colors.green[100] : Colors.red[100],
          child: ListTile(
            leading: Text(todo.id.toString()),
            title: Text(todo.title),
            trailing: Obx(() => IconButton(
              icon: Icon(
                saveTodoController.saveTodo.any(
                        (item) => item.id == todo.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: themeController.isDarkTheme.value
                    ? Colors.white
                    : Colors.purple.shade800,
              ),
              onPressed: () {
                saveTodoController.toggleBookmark(todo);
              },
            )),
          ),
        );
      },
    );
  }
}
