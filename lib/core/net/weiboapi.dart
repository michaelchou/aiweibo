import 'package:aiweibo/core/config/privateconfig.dart';

///
/// WeiBo API 接口的封装
/// 参考地址：http://open.weibo.com/wiki/微博API
///
///

abstract class WeiBoApi {
  static const String APP_BASE_URL = 'https://api.weibo.com/2/';
  static const String AUTH2_URL = 'https://api.weibo.com/oauth2/';

  /// 认证授权接口
  // --请求用户授权Token
  // --接口：http://open.weibo.com/wiki/Oauth2/authorize
  static getAuthorize() =>
      '${AUTH2_URL}authorize?client_id=${AppValue.APP_ID}&redirect_uri=https://www.baidu.com&response_type=code';

  // --获取授权过的Access Token
  // --接口地址：https://api.weibo.com/oauth2/access_token
  static getAuthAccessToken() =>
      '${AUTH2_URL}access_token?client_id=${AppValue.APP_ID}&client_secret=${AppValue.APP_SECRET}&grant_type=authorization_code';

  /// 用户接口
  // --根据用户ID获取用户信息
  // --接口：https://api.weibo.com/2/users/show.json
  static getUserShow() => '${APP_BASE_URL}users/show.json';

  // --通过个性化域名获取用户资料以及用户最新的一条微博
  // --接口：https://api.weibo.com/2/users/domain_show.json
  static getUserDomainShow() => '${APP_BASE_URL}users/domain_show.json';

  // --批量获取用户的粉丝数、关注数、微博数
  // --接口：https://api.weibo.com/2/users/counts.json
  static getUserCounts() => '${APP_BASE_URL}users/counts.json';

  /// 评论
  // --获取某条微博的评论列表
  // --https://api.weibo.com/2/comments/show.json
  static getCommentsShow() => '${APP_BASE_URL}comments/show.json';

  // --我发出的评论列表
  // --https://api.weibo.com/2/comments/by_me.json
  static getCommentsByMe() => '${APP_BASE_URL}users/by_me.json';

  // --我收到的评论列表
  // --https://api.weibo.com/2/comments/to_me.json
  static getCommentsToMe() => '${APP_BASE_URL}users/to_me.json';

  // --获取用户发送及收到的评论列表
  // --https://api.weibo.com/2/comments/timeline.json
  static getCommentsTimeline() => '${APP_BASE_URL}users/timeline.json';

  // --获取@到我的评论
  // --https://api.weibo.com/2/comments/mentions.json
  static getCommentsMentions() => '${APP_BASE_URL}users/mentions.json';

  // --批量获取评论内容
  // --https://api.weibo.com/2/comments/show_batch.json
  static getCommentsShowBatch() => '${APP_BASE_URL}users/show_batch.json';

  /// 评论-写入接口
  // --评论一条微博
  // --https://api.weibo.com/2/comments/create.json
  static createComments() => '${APP_BASE_URL}users/create.json';

  // --删除我的一条评论
  // --https://api.weibo.com/2/comments/destroy.json
  static destroyComments() => '${APP_BASE_URL}users/destroy.json';

  // --批量删除我的评论
  // --https://api.weibo.com/2/comments/destroy_batch.json
  static destroyCommentsBatch() => '${APP_BASE_URL}users/destroy_batch.json';

  // --回复一条评论
  // --https://api.weibo.com/2/comments/reply.json
  static replyComments() => '${APP_BASE_URL}users/reply.json';

  /// WeiBo内容
  // --获取当前登录用户及其所关注用户的最新微博
  // --接口：https://api.weibo.com/2/statuses/home_timeline.json
  static getStatusesHomeTimeline() => '${APP_BASE_URL}statuses/home_timeline.json';

  // 获取某个用户最新发表的微博列表
  // --接口：https://api.weibo.com/2/statuses/user_timeline.json
  static getStatusesUserTimeline() => '${APP_BASE_URL}statuses/user_timeline.json';

  // 返回一条原创微博的最新转发微博
  // --接口：https://api.weibo.com/2/statuses/repost_timeline.json
  static getStatusesRepostTimeline() => '${APP_BASE_URL}statuses/repost_timeline.json';

  // 获取@当前用户的最新微博
  // --接口：https://api.weibo.com/2/statuses/mentions.json
  static getStatusesMentions() => '${APP_BASE_URL}statuses/mentions.json';

  // 根据ID获取单条微博信息
  // --接口：https://api.weibo.com/2/statuses/show.json
  static getStatusesShow() => '${APP_BASE_URL}statuses/show.json';

  // 批量获取指定微博的转发数评论数
  // --https://api.weibo.com/2/statuses/count.json
  static getStatusesCount() => '${APP_BASE_URL}statuses/count.json';

  // 根据ID跳转到单条微博页
  // --http://api.weibo.com/2/statuses/go
  static goStatuses() => '${APP_BASE_URL}statuses/go.json';

  // 获取微博官方表情的详细信息
  // --https://api.weibo.com/2/emotions.json
  static getEmotions() => '${APP_BASE_URL}emotions.json';
}
