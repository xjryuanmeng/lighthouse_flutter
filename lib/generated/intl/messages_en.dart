// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "cancel" : MessageLookupByLibrary.simpleMessage("cancel"),
    "clickRegister" : MessageLookupByLibrary.simpleMessage("点此注册"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "forgetPassword" : MessageLookupByLibrary.simpleMessage("Forget Password?"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginPhone" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "loginPhoneError" : MessageLookupByLibrary.simpleMessage("Phone number cannot be empty!"),
    "loginPhoneHint" : MessageLookupByLibrary.simpleMessage("Please enter your phone number"),
    "loginSuccess" : MessageLookupByLibrary.simpleMessage("Login Success"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "noAccount" : MessageLookupByLibrary.simpleMessage("没有账号？"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordError" : MessageLookupByLibrary.simpleMessage("Password cannot be less than 6 digits!"),
    "passwordHint" : MessageLookupByLibrary.simpleMessage("Please enter your password"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "registerSuccess" : MessageLookupByLibrary.simpleMessage("Register Success"),
    "repeatPassword" : MessageLookupByLibrary.simpleMessage("Repeat Password"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "welcomeLogin" : MessageLookupByLibrary.simpleMessage("Welcome Login"),
    "welcomeRegist" : MessageLookupByLibrary.simpleMessage("Welcome Regist")
  };
}