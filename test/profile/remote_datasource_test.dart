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
  var remoteDataSource = MockProfileRemoteDataSource();

  const int userId = 1;
  const int page = 1;

  ProfileModel fakeProfileModel = const ProfileModel(
    id: userId,
    email: "user1@gmail.com",
    firstName: "user",
    lastName: "$userId",
    avatar: "https://image.com/$userId",
  );

  group("Profile Remote Data Source", () {
    group("getUser()", () {
      test("BERHASIL", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(remoteDataSource.getUser(userId)).thenAnswer(
          (_) async => fakeProfileModel,
        );

        try {
          var respose = await remoteDataSource.getUser(userId);

          expect(respose, fakeProfileModel);
          // TESTING UNTUK KEBERHASILAN
        } catch (e) {
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        }
      });

      test("GAGAL", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(remoteDataSource.getUser(userId)).thenThrow(Exception());

        try {
          var respose = await remoteDataSource.getUser(userId);

          fail("TIDAK MUNGKIN TERJADI");
          // TIDAK MUNGKIN TERJADI ERROR
        } catch (e) {
          // TESTING UNTUK KEGAGALAN
          expect(e, isException);
        }
      });
    });

    group("getAllUser()", () {
      test("BERHASIL", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(remoteDataSource.getAllUser(page)).thenAnswer(
          (_) async => [fakeProfileModel],
        );

        try {
          var respose = await remoteDataSource.getAllUser(page);

          expect(respose, [fakeProfileModel]);
          // TESTING UNTUK KEBERHASILAN
        } catch (e) {
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        }
      });

      test("GAGAL", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(remoteDataSource.getAllUser(page)).thenThrow(Exception());

        try {
          var respose = await remoteDataSource.getAllUser(page);

          fail("TIDAK MUNGKIN TERJADI");
          // TIDAK MUNGKIN TERJADI ERROR
        } catch (e) {
          // TESTING UNTUK KEGAGALAN
          expect(e, isException);
        }
      });
    });
  });
}
