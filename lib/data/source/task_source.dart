import 'package:course_task_app/common/urls.dart';
import 'package:d_method/d_method.dart';
import 'package:dio/dio.dart';

class TaskSource {
  /// `'${URLs.host}/tasks'`
  static const _baseURL = '${URLs.host}/tasks';

  static final Dio _dio = Dio();

  static Future<bool> add(
    String title,
    String description,
    String dueDate,
    int userId,
  ) async {
    try {
      final response = await _dio.post(
        _baseURL,
        data: {
          "title": title,
          "description": description,
          "status": "Queue",
          "dueDate": dueDate,
          "userId": userId
        },
      );
      DMethod.logResponse(response.data);

      return response.statusCode == 201;
    } catch (e) {
      DMethod.log(e.toString(), colorCode: 1);
      return false;
    }
  }
}
