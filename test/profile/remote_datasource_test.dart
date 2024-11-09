// MOCK -> ProfileRemoteDataSource

import 'package:clean_architecture_flutter/features/profile/data/datasources/remote_datasource.dart';
import 'package:clean_architecture_flutter/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<ProfileRemoteDataSource>()])
import 'remote_datasource_test.mocks.dart';

void main() async {
  // Create mock object.
  var remoteDataSource = MockProfileRemoteDataSource();

  const int userId = 1;

  ProfileModel fakeProfileModel = const ProfileModel(
    id: userId,
    email: "user1@gmail.com",
    firstName: "user",
    lastName: "$userId",
    avatar: "https://image.com/$userId",
  );

  group(
    "Profile Remote Data Source",
    () {
      test(
        "BERHASIL",
        () async {
          // Stub -> kondisi untuk kita palsukan
          // Proses Stubbing
          when(remoteDataSource.getUser(userId)).thenAnswer(
            (_) async => fakeProfileModel,
          );

          try {
            var respose = await remoteDataSource.getUser(userId);
            print(respose.toJson());
            // TESTING UNTUK KEBERHASILAN
          } catch (e) {
            // TIDAK MUNGKIN TERJADI ERROR
            print(e);
          }
        },
      );

      test(
        "GAGAL",
        () async {
          // Stub -> kondisi untuk kita palsukan
          // Proses Stubbing
          when(remoteDataSource.getUser(userId)).thenThrow(Exception());

          try {
            var respose = await remoteDataSource.getUser(userId);
            print(respose.toJson());
            // TIDAK MUNGKIN TERJADI ERROR
          } catch (e) {
            // TESTING UNTUK KEGAGALAN
            print(e);
          }
        },
      );
    },
  );
}
