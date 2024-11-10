import 'package:bloc/bloc.dart';
import 'package:clean_architecture_flutter/features/profile/data/models/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_flutter/observer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/routes/my_router.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ProfileModelAdapter());
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router,
    );
  }
}
