

import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class UserRepo
{
  final ApiClient apiClint;
  UserRepo({required this.apiClint});
  Future<Response> getUserInfo()
  async {
    return await apiClint.getData(AppConstants.user_info_URI);
  }
}