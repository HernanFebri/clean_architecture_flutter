import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Users"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.pushNamed(
                "detail_user",
                extra: index + 1,
              ); // package go_router
            },
            title: Text("User ${index + 1}"),
          );
        },
      ),
    );
  }
}
