// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "clickRegister" : MessageLookupByLibrary.simpleMessage("点此注册"),
    "close" : MessageLookupByLibrary.simpleMessage("关闭"),
    "forgetPassword" : MessageLookupByLibrary.simpleMessage("忘记密码？"),
    "login" : MessageLookupByLibrary.simpleMessage("登录"),
    "loginPhone" : MessageLookupByLibrary.simpleMessage("手机号"),
    "loginPhoneError" : MessageLookupByLibrary.simpleMessage("手机号不能为空!"),
    "loginPhoneHint" : MessageLookupByLibrary.simpleMessage("请输入手机号"),
    "loginSuccess" : MessageLookupByLibrary.simpleMessage("登录成功"),
    "logout" : MessageLookupByLibrary.simpleMessage("登出"),
    "noAccount" : MessageLookupByLibrary.simpleMessage("没有账号？"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "passwordError" : MessageLookupByLibrary.simpleMessage("密码不能少于6位!"),
    "passwordHint" : MessageLookupByLibrary.simpleMessage("请输入密码"),
    "register" : MessageLookupByLibrary.simpleMessage("注册"),
    "registerSuccess" : MessageLookupByLibrary.simpleMessage("注册成功"),
    "repeatPassword" : MessageLookupByLibrary.simpleMessage("重复密码"),
    "settings" : MessageLookupByLibrary.simpleMessage("设置"),
    "welcomeLogin" : MessageLookupByLibrary.simpleMessage("欢迎登录"),
    "welcomeRegist" : MessageLookupByLibrary.simpleMessage("欢迎注册")
  };
}