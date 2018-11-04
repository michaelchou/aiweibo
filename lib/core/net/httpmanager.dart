import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

import 'package:aiweibo/core/config/config.dart';
import 'package:aiweibo/core/net/resultdata.dart';
import 'package:aiweibo/core/net/responsecode.dart';
import 'package:aiweibo/core/storage/localstorage.dart';

class HttpManager {
  static Map optionParams = {
    HttpConfig.TIMEOUT_KEY: HttpConfig.REQUEST_TIMEOUT,
//    HttpConfig.TOKEN_KEY: null,
    HttpConfig.AUTH_KEY: null,
  };

  static send(url, {params, Map<String, String> header, Options option,
      noTip = false}) async {
    // 网络检查
//    var connectivityResult = await (new Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.none) {
//      return new ResultData(
//          Code.errorHandleFunction(
//              Code.NETWORK_ERROR, '', noTip),
//          false,
//          Code.NETWORK_ERROR);
//    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    // 授权
    if (optionParams[HttpConfig.AUTH_KEY] == null) {
      var authCode = await _getAuthorization();
      if (authCode != null) {
        optionParams[HttpConfig.AUTH_KEY] = authCode;
      }
    }

    // headers
    headers[HttpConfig.AUTH_KEY] = optionParams[HttpConfig.AUTH_KEY];

    if (option == null) {
      option = new Options(method: 'get');
    }
    option.headers = headers;
    option.connectTimeout = HttpConfig.REQUEST_TIMEOUT;

    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: Code.NETWORK_TIMEOUT);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }

      if (Config.DEBUG) {
        print('请求异常：' + e.toString());
        print('请求异常url：' + url);
      }
      return new ResultData(
          Code.errorHandleFunction(
              errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    if (Config.DEBUG) {
      print('请求url：$url');
      print('请求header：' + option.headers.toString());
      if (params != null) {
        print('请求参数：' + params.toString());
      }
      if (response != null) {
        print('返回参数：' + response.toString());
        print(HttpConfig.AUTH_KEY + '：' + optionParams[HttpConfig.AUTH_KEY]);
      }
    }

    try {
      if (option.contentType != null &&
          option.contentType.primaryType == 'text') {
        return new ResultData(response.data, true, Code.SUCCESS);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 201 &&
            responseJson[HttpConfig.TOKEN_KEY] != null) {
          optionParams[HttpConfig.AUTH_KEY] =
              'token ' + responseJson[HttpConfig.TOKEN_KEY];
          LocalStorage.save(
              HttpConfig.TOKEN_KEY, optionParams[HttpConfig.AUTH_KEY]);
        }
      }
      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return new ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
    }
    return new ResultData(Code.errorHandleFunction(response.statusCode, '', noTip), false, response.statusCode);
  }

  _clearAuthorization() {
    optionParams[HttpConfig.AUTH_KEY] = null;
    LocalStorage.remove(HttpConfig.TOKEN_KEY);
  }

  static _getAuthorization() async {
    String token = await LocalStorage.get(HttpConfig.TOKEN_KEY);
    if (token == null) {
      String basicCode = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basicCode == null) {
        // 提示输入账号密码
      } else {
        return 'Basic $basicCode';
      }
    } else {
      optionParams[HttpConfig.AUTH_KEY] = token;
      return token;
    }
  }
}
