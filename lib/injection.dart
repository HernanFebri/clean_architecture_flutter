import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'features/profile/data/datasources/local_datasource.dart';
import 'features/profile/data/datasources/remote_datasource.dart';
import 'features/profile/data/models/profile_model.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

var myinjection =
    GetIt.instance; // merupakan tempat penampungan semua dependencies

// INJECT semua dependencies
Future<void> init() async {
  // GENERAL DEPENDENCIES
  // HIVE
  Hive.registerAdapter(ProfileModelAdapter());
  var box = await Hive.openBox("profile_box");
  myinjection.registerLazySingleton(
    () => box,
  );

  // HTTP
  myinjection.registerLazySingleton(
    () => http.Client(),
  );

  // FEATURE - PROFILE
  // BLOC
  myinjection.registerFactory(
    () => ProfileBloc(
      getAllUser: myinjection(),
      getUser: myinjection(),
    ),
  );
  // USECASE
  myinjection.registerLazySingleton(
    () => GetAllUser(myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GetUser(myinjection()),
  );
  // REPOSITORY
  myinjection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
      myinjection(),
      profileRemoteDataSource: myinjection(),
      profileLocalDataSource: myinjection(),
    ),
  );
  // DATA SOURCE
  myinjection.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImplementation(
      box: myinjection(),
    ),
  );

  myinjection.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplementation(
      client: myinjection(),
    ),
  );
}
