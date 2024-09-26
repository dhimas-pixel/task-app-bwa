import 'package:course_task_app/common/urls.dart';
import 'package:d_method/d_method.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class TaskSource {
  /// `'${URLs.host}/tasks'`
  static const _baseURL = '${URLs.host}/tasks';

  static final Dio _dio = Dio();

  static Future<bool> add({
    required String title,
    required String description,
    required String dueDate,
    required int userId,
  }) async {
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

  static Future<bool> delete({
    required int userId,
  }) async {
    try {
      final response = await _dio.delete(
        '$_baseURL/$userId',
      );

      DMethod.logResponse(response.data);
      return response.statusCode == 200;
    } catch (e) {
      DMethod.log(e.toString(), colorCode: 1);
      return false;
    }
  }

  static Future<bool> submit({
    required int id,
    required XFile xfile,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'submitDate': DateTime.now().toIso8601String(),
        'attachment': await MultipartFile.fromFile(
          xfile.path,
          filename: xfile.name,
        ),
      });

      final response = await _dio.patch(
        '$_baseURL/$id/submit',
        data: formData,
      );

      return response.statusCode == 200;
    } catch (e) {
      // Menangkap error dan log pesan error
      DMethod.log(e.toString(), colorCode: 1);
      return false;
    }
  }

  static Future<bool> reject({
    required String reason,
    required int id,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'rejectedDate': DateTime.now().toIso8601String(),
        'reason': reason,
      });

      final response = await _dio.patch(
        '$_baseURL/$id/reject',
        data: formData,
      );

      return response.statusCode == 200;
    } catch (e) {
      // Menangkap error dan log pesan error
      DMethod.log(e.toString(), colorCode: 1);
      return false;
    }
  }
}
