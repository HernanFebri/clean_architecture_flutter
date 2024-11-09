import 'package:clean_architecture_flutter/features/profile/data/datasources/remote_datasource.dart';

void main() async {
  // BENTUK TESTING SEDERHANA -> belum keliatan % coverage
  final ProfileRemoteDataSourceImplementation
      profileRemoteDataSourceImplementation =
      ProfileRemoteDataSourceImplementation();

  try {
    var response = await profileRemoteDataSourceImplementation.getUser(20);
    print(response.toJson());
  } catch (e) {
    print(e);
  }
}
