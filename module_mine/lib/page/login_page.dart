import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:library_base/constant/constant.dart';
import 'package:library_base/generated/l10n.dart';
import 'package:library_base/mvvm/base_page.dart';
import 'package:library_base/model/account.dart';
import 'package:library_base/global/rt_account.dart';
import 'package:library_base/net/apis.dart';
import 'package:library_base/res/colors.dart';
import 'package:library_base/res/gaps.dart';
import 'package:library_base/res/styles.dart';
import 'package:library_base/router/parameters.dart';
import 'package:library_base/router/routers.dart';
import 'package:library_base/widget/button/gradient_button.dart';
import 'package:library_base/widget/button/round_checkbox.dart';
import 'package:library_base/widget/common_scroll_view.dart';
import 'package:library_base/widget/dialog/dialog_util.dart';
import 'package:library_base/widget/image/local_image.dart';
import 'package:library_base/widget/textfield/account_text_field.dart';
import 'package:library_base/widget/textfield/pwd_text_field.dart';
import 'package:library_base/utils/date_util.dart';
import 'package:library_base/utils/encrypt_util.dart';
import 'package:library_base/utils/object_util.dart';
import 'package:library_base/utils/other_util.dart';
import 'package:library_base/utils/toast_util.dart';
import 'package:module_mine/mine_router.dart';
import 'package:module_mine/viewmodel/login_model.dart';
import 'package:module_mine/widget/third_login_bar.dart';

class LoginPage extends StatefulWidget {
  final String? phone;
  final bool agreeChecked;

  LoginPage({
    this.phone,
    this.agreeChecked = false,
  });
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BasePageMixin<LoginPage> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();

  late LoginModel _loginModel;

  String? _area_code;
  bool _loginEnabled = false;
  bool _agreeChecked = false;

  @override
  void initState() {
    super.initState();

    initView();
    initViewModel();

    _checkInput();
  }

  void initView() {
    _area_code = '+86';
    _agreeChecked = widget.agreeChecked;
    if (!ObjectUtil.isEmpty(widget.phone)) {
      _phoneController.text = widget.phone!;

    } else {
      Account? account = RTAccount.instance()!.loadAccount();
      if (account != null) {
        // var t = account.phone?.split(' ');
        // _area_code = t?.first;
        // _phoneController.text = t?.last;
        _phoneController.text = account.phone!;
      }
    }
  }

  void initViewModel() {
    _loginModel = LoginModel();
    _loginModel.addListener(() {
      if (_loginModel.isBusy) {
        showProgress(content: S.current.logingin);
      } else if (_loginModel.isError) {
        closeProgress();
        if (_loginModel.viewStateError?.errno == Apis.ERRNO_NOT_SET_PASSWORD) {
          DialogUtil.showCupertinoAlertDialog(context,
              title: S.of(context).notSetPassword,
              content:  S.of(context).notSetPasswordTips,
              cancel: S.of(context).cancel,
              confirm: S.of(context).smsLogin,
              cancelPressed: () => Navigator.of(context).pop(),
              confirmPressed: () {
                Navigator.of(context).pop();
                _smsLogin();
              }
          );

        } else {
          ToastUtil.error(_loginModel.viewStateError!.message!);
        }

      } else if (_loginModel.isSuccess) {
        closeProgress();

        String? phone = _loginModel.loginResult?.account_info?.phone;

        if (ObjectUtil.isEmpty(phone)) {
          Routers.navigateTo(context, Routers.bindPhonePage);

        } else {
          ToastUtil.success(S.current.logingSuccess);
          Routers.navigateTo(context, MineRouter.isRunModule ? Routers.minePage : Routers.mainPage, clearStack: true);
        }
      }
    });
  }

  void _checkInput() {
    setState(() {
      if (!_agreeChecked || ObjectUtil.isEmpty(_phoneController.text) || ObjectUtil.isEmpty(_pwdController.text)) {
        _loginEnabled = false;
      } else {
        _loginEnabled = true;
      }
    });
  }

  void _login() {
    String phone = _phoneController.text;
    String pwd = _pwdController.text;
    int nonce = DateUtil.getNowDateMs() * 1000;
    String pwdMd5 = EncryptUtil.encodeMd5(EncryptUtil.encodeMd5(pwd) + nonce.toString()).toLowerCase();

    _loginModel.login(phone, pwdMd5, nonce);
  }

  void _selectArea() {
    Parameters params = Parameters()
      ..putString('areaCode', _area_code!);

    Routers.navigateToResult(context, Routers.areaPage, params, (result) {
      setState(() {
        _area_code = result as String?;
      });
    }, transition: TransitionType.materialFullScreenDialog);
  }

  void _smsLogin() {
    Parameters params = Parameters()
      ..putString('phone', _phoneController.text)
      ..putBool('agreeChecked', _agreeChecked);

    Routers.navigateTo(context, Routers.loginSmsPage, parameters: params, clearStack: true);
  }

  void _forgetPwd() {
    Routers.navigateTo(context, Routers.forgetPwdPage);
  }

  void _jump2Agreement() {
    Parameters params = Parameters()
      ..putString('title', S.current.registAgreement)
      ..putString('url', Apis.URL_REGIST_AGREEMENT)
      ..putBool('show_share', false);

    Routers.navigateTo(context, Routers.inappWebviewPage, parameters: params);
  }

  void _jump2Privacy() {
    Parameters params = Parameters()
      ..putString('title', S.current.privatePolicy)
      ..putString('url', Apis.URL_PRIVATE_POLICY)
      ..putBool('show_share', false);

    Routers.navigateTo(context, Routers.inappWebviewPage, parameters: params);
  }

  void _jump2Disclaimer() {
    Parameters params = Parameters()
      ..putString('title', S.current.discaimer)
      ..putString('url', Apis.URL_DISCAIMER)
      ..putBool('show_share', false);

    Routers.navigateTo(context, Routers.inappWebviewPage, parameters: params);
  }

  void _skip() {
    Routers.navigateTo(context, MineRouter.isRunModule ? Routers.minePage : Routers.mainPage, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colours.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colours.white,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton(
                padding: EdgeInsets.all(0),
                minWidth: 70,
                disabledTextColor: Colours.gray_500,
                textColor: Colours.gray_400,
                child: Text(S.of(context).skip, style: TextStyle(fontSize: 15)),
                onPressed: _skip
            )
          ],
        ),
        body: CommonScrollView(
          keyboardConfig: OtherUtil.getKeyboardActionsConfig(context, <FocusNode>[_phoneNode, _pwdNode]),
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
          children: <Widget>[
            Gaps.vGap32,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: LocalImage('logo', package: Constant.baseLib, width: 60, height: 60,),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 22,
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(S.of(context).pwdLogin,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textGray800_w600_20)
                  ),
                ),
              ],
            ),
            Gaps.vGap32,

            AccountTextField(
              focusNode: _phoneNode,
              controller: _phoneController,
              onTextChanged: _checkInput,
              areaCode: _area_code,
              onPrefixPressed: _selectArea,
            ),
            Gaps.vGap16,
            PwdTextField(
              focusNode: _pwdNode,
              controller: _pwdController,
              onTextChanged: _checkInput,
            ),
            Gaps.vGap24,
            Container(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundCheckBox(
                      value: _agreeChecked,
                      onChanged: (value) {
                        setState(() {
                          _agreeChecked = value;
                          _checkInput();
                        });
                      },
                    ),
                    Expanded(child: Container(
                        padding: EdgeInsets.only(top: 7),
                        child: Text.rich(TextSpan(
                            children: [
                              TextSpan(text: S.of(context).loginPolicy, style: TextStyles.textGray400_w400_14),
                              TextSpan(text: S.of(context).registAgreement, style: TextStyles.textMain14,
                                  recognizer: new TapGestureRecognizer()..onTap = _jump2Agreement),
                              TextSpan(text: S.of(context).privatePolicy, style: TextStyles.textMain14,
                                  recognizer: new TapGestureRecognizer()..onTap = _jump2Privacy),
                              TextSpan(text: S.of(context).loginPolicyAnd, style: TextStyles.textGray400_w400_14),
                              TextSpan(text: S.of(context).discaimer, style: TextStyles.textMain14,
                                  recognizer: new TapGestureRecognizer()..onTap = _jump2Disclaimer),
                            ]
                        ),
                          strutStyle: StrutStyle(forceStrutHeight: true, height:1, leading: 0.5),
                          textAlign: TextAlign.left,
                        )
                    ))
                  ],
                )
            ),
            Gaps.vGap24,
            GradientButton(
              width: double.infinity,
              height: 48,
              text: S.of(context).login,
              colors: <Color>[   //背景渐变
                Colours.app_main,
                Colours.app_main_500
              ],
              onPressed: _loginEnabled ? _login : null,
            ),
            Gaps.vGap16,
            Container(
              height: 40.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      S.of(context).smsLogin,
                      style: TextStyles.textGray500_w400_15,
                    ),
                    onTap: _smsLogin,
                  ),
                  InkWell(
                    child: Text(
                      S.of(context).forgetPassword,
                      style: TextStyles.textGray500_w400_15,
                    ),
                    onTap: _forgetPwd,
                  )
                ],
              ),
            ),
          ],
          bottomButton: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ThirdLoginBar(
                onWeChatAuthResponse: (res) {
                  if (res.code != null) {
                    _loginModel.loginWechat(res.code);
                  }
                }
            ),
          )
        )
    );
  }

}
