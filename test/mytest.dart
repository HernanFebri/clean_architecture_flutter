import 'package:clean_architecture_flutter/features/profile/data/datasources/remote_datasource.dart';

void main() async {
  final ProfileRemoteDataSourceImplementation
      profileRemoteDataSourceImplementation =
      ProfileRemoteDataSourceImplementation();

  var response = await profileRemoteDataSourceImplementation.getUser(1);

  print(response.toJson());
}
