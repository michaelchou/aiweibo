///
/// @author MichaelChou
/// @date 2018/11/4 1:24 PM
/// Defined http event
///

class HttpErrorEvent {
  final int code;
  final String message;

  HttpErrorEvent(this.code, this.message);
}