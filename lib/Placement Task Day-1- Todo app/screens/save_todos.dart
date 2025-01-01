
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/save_todo_controller.dart';
import '../controller/theme_controller.dart';

class SaveTodoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SaveTodoController todoController = Get.put(SaveTodoController());
    final ThemeController themeController = Get.put(ThemeController());

    final isDarkTheme = themeController.isDarkTheme.value;
    return Obx( () =>
        Scaffold(
          backgroundColor: isDarkTheme ? Colors.black38 : Colors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: themeController.isDarkTheme.value ? Colors.white : Colors.white,
              ),
            ),
            title: Text(
              'Saved Todos',
              style: TextStyle(
                color: themeController.isDarkTheme.value ? Colors.white : Colors.white,
              ),
            ),
            backgroundColor: themeController.isDarkTheme.value ? Colors.black : Colors.purple.shade800,
          ),
          body: Obx(
                () {
              final saveTodo = todoController.saveTodo;
              return saveTodo.isEmpty
                  ? Center(
                  child: Text(
                    'No saved todos',
                    style: TextStyle(
                      color: themeController.isDarkTheme.value
                          ? Colors.white
                          : Colors.black, // Theme-based text color
                    ),
                  ))
                  : ListView.builder(
                itemCount: saveTodo.length,
                itemBuilder: (context, index) {
                  final todo = saveTodo[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: themeController.isDarkTheme.value
                          ? Colors.grey[850]
                          : Colors.white,
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              todo.completed ? 'Completed' : 'Pending',
                              style: TextStyle(
                                color: todo.completed
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Icon(
                              todo.completed
                                  ? Icons.check_circle
                                  : Icons.error,
                              color:
                              todo.completed ? Colors.green : Colors.red,
                              size: 13,
                            )
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              todoController.toggleBookmark(todo);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: themeController.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.red,
                            )),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
    );
  }
}
