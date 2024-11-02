import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserView extends StatelessWidget {
  final UserController _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX & MVVM Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUserInput(nameController),
            const SizedBox(height: 20),
            _buildUserList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInput(TextEditingController nameController) {
    return TextField(
      controller: nameController,
      decoration: const InputDecoration(
        hintText: "Enter name",
        border: OutlineInputBorder(),
      ),
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          _controller.insertUser(value, 25);
          nameController.clear();
        }
      },
    );
  }

  Widget _buildUserList() {
    return Expanded(
      child: Obx(() {
        if (_controller.users.isEmpty) {
          return const Center(
            child: Text("No users found."),
          );
        }
        return ListView.builder(
          itemCount: _controller.users.length,
          itemBuilder: (context, index) {
            final user = _controller.users[index];
            return ListTile(
              title: Text('Name: ${user.name}'),
              subtitle: Text('Age: ${user.age}'),
            );
          },
        );
      }),
    );
  }
}
