import 'package:event_bus/event_bus.dart';

import 'package:aiweibo/core/event/httpevent.dart';
///
/// @author MichaelChou
/// @date 2018/11/4 1:15 PM
/// Defined response code
///

class Code {
  // 网络错误
  static const NETWORK_ERROR = -1;
  // 网络超时
  static const NETWORK_TIMEOUT = -2;
  // 网络返回数据格式化错
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static final EventBus eventBus = new EventBus();

  static errorHandleFunction(code , message, noTip) {
    if (noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}