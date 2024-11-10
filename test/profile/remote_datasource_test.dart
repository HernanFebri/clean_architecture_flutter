// INSTRUCTION FOR GENERATE COVERAGE BY NANZ

// >> flutter pub get
// >> flutter pub run build_runner build --delete-conflicting-outputs
// >> flutter test --machine > tests.output

// INI KALAU MAU TEST SEMUA FOLDER YANG ADA DI TEST
// >> flutter test --coverage

// INI KALAU MAU TEST SPESIFIK FOLDER YANG ADA DI TEST
// >> flutter test test/profile --coverage

// GENERATE HTML
// >> genhtml coverage/lcov.info -o coverage/html --legend -t "Clean Architecture by Nanz" --function-coverage

// OPEN HTML
// >> open coverage/html/index.html

// REMOVE
// >> lcov -- remove coverage/lcov.info "lib/core/error/*" "lib/features/profile/data/models/*" -o coverage/lcov.info

// MOCK -> ProfileRemoteDataSource

import 'dart:convert';

import 'package:clean_architecture_flutter/core/error/exception.dart';
import 'package:clean_architecture_flutter/features/profile/data/datasources/remote_datasource.dart';
import 'package:clean_architecture_flutter/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'remote_datasource_test.mocks.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks(
    [MockSpec<ProfileRemoteDataSource>(), MockSpec<http.Client>()])
void main() {
  var remoteDataSource =
      MockProfileRemoteDataSource(); // Kelas Tipuan (Fake Class)
  MockClient mockClient = MockClient();
  var remoteDataSourceImplementation = ProfileRemoteDataSourceImplementation(
      client: mockClient); // Kelas Tipuan (Fake Class)

  const int userId = 1;
  const int page = 1;
  Uri urlGetAllUser = Uri.parse("https://reqres.in/api/users?page=$page");
  Uri urlGetUser = Uri.parse("https://reqres.in/api/users/$userId");

  Map<String, dynamic> fakeDataJson = {
    "id": userId,
    "email": "user1@gmail.com",
    "first_name": "user",
    "last_name": "$userId",
    "avatar": "https://image.com/$userId",
  };

  ProfileModel fakeProfileModel = ProfileModel.fromJson(fakeDataJson);

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
          await remoteDataSource.getUser(userId);

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
          await remoteDataSource.getAllUser(page);

          fail("TIDAK MUNGKIN TERJADI");
          // TIDAK MUNGKIN TERJADI ERROR
        } catch (e) {
          // TESTING UNTUK KEGAGALAN
          expect(e, isException);
        }
      });
    });
  });

  group("Profile Remote Data Source Implementation", () {
    group("getUser()", () {
      test("BERHASIL (200)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": fakeDataJson,
            }),
            200,
          ),
        );

        try {
          var respose = await remoteDataSourceImplementation.getUser(userId);
          expect(respose, fakeProfileModel);
          // TESTING UNTUK KEBERHASILAN
        } catch (e) {
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        }
      });

      test("GAGAL (404)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            404,
          ),
        );

        try {
          await remoteDataSourceImplementation.getUser(userId);
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        } on EmptyException catch (e) {
          // TESTING UNTUK KEGAGALAN 404
          expect(e, isException);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test("GAGAL (500)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            500,
          ),
        );

        try {
          await remoteDataSourceImplementation.getUser(userId);
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        } on EmptyException {
          // TESTING UNTUK KEGAGALAN 404
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group("getAllUser()", () {
      test("BERHASIL (200)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": [fakeDataJson],
            }),
            200,
          ),
        );

        try {
          var respose = await remoteDataSourceImplementation.getAllUser(page);
          expect(respose, [fakeProfileModel]);
          // TESTING UNTUK KEBERHASILAN
        } on EmptyException {
          fail("TIDAK MUNGKIN TERJADI");
        } on StatusCodeException {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test("GAGAL (EMPTY)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": [],
            }),
            200,
          ),
        );

        try {
          await remoteDataSourceImplementation.getAllUser(page);
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        } on EmptyException catch (e) {
          // TESTING UNTUK KEGAGALAN EMPTY
          expect(e, isException);
        } on StatusCodeException {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });
      test("GAGAL (404)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            404,
          ),
        );

        try {
          await remoteDataSourceImplementation.getAllUser(page);
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        } on EmptyException {
          fail("TIDAK MUNGKIN TERJADI");
        } on StatusCodeException catch (e) {
          // TESTING UNTUK KEGAGALAN 404
          expect(e, isException);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test("GAGAL (500)", () async {
        // Stub -> kondisi untuk kita palsukan
        // Proses Stubbing
        when(mockClient.get(urlGetAllUser)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({}),
            500,
          ),
        );

        try {
          await remoteDataSourceImplementation.getAllUser(page);
          // TIDAK MUNGKIN TERJADI ERROR
          fail("TIDAK MUNGKIN TERJADI ");
        } on EmptyException {
          fail("TIDAK MUNGKIN TERJADI");
        } on StatusCodeException {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          // TESTING UNTUK KEGAGALAN 404
          expect(e, isException);
        }
      });
    });
  });
}
