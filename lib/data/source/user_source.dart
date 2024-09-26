import 'package:course_task_app/common/urls.dart';
import 'package:course_task_app/data/models/user.dart';
import 'package:d_method/d_method.dart';
import 'package:dio/dio.dart';

class UserSource {
  static const _baseUrl = '${URLs.host}/users';
  static final Dio _dio = Dio();

  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      DMethod.logResponse(response.data);

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }

      return null;
    } catch (e) {
      DMethod.log(e.toString(), colorCode: 1);
      return null;
    }
  }

  static Future<bool> addEmployee({
    required String email,
    required String name,
  }) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: {
          "name": name,
          "email": email,
        },
      );

      DMethod.logResponse(response.data);
      return response.statusCode == 201;
    } catch (e) {
      DMethod.log(e.toString(), colorCode: 1);
      return false;
    }
  }

  static Future<bool> delete({
    required String userId,
  }) async {
    try {
      final response = await _dio.delete(
        '$_baseUrl/$userId',
      );

      DMethod.logResponse(response.data);
      return response.statusCode == 200;
    } catch (e) {
      DMethod.log(e.toString(), colorCode: 1);
      return false;
    }
  }

  static Future<List<User>?> getEmployee() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/employee',
      );

      DMethod.logResponse(response.data);

      if (response.statusCode == 200) {
        return response.data.map((e) => User.fromJson(e)).toList();
      }

      return null;
    } catch (e) {
      DMethod.log(e.toString(), colorCode: 1);
      return null;
    }
  }
}
