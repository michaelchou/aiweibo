///
/// @author MichaelChou
/// @date 2018/11/4 1:12 PM
/// Result data for httpManager send response
///

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});

}