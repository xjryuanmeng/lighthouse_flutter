
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:lighthouse/event/event.dart';
import 'package:lighthouse/event/user_event.dart';
import 'package:lighthouse/generated/l10n.dart';
import 'package:lighthouse/net/model/account.dart';
import 'package:lighthouse/net/rt_account.dart';
import 'package:lighthouse/res/colors.dart';
import 'package:lighthouse/res/gaps.dart';
import 'package:lighthouse/res/styles.dart';
import 'package:lighthouse/router/routers.dart';
import 'package:lighthouse/ui/page/base_page.dart';
import 'package:lighthouse/ui/widget/appbar/mine_appbar.dart';
import 'package:lighthouse/ui/widget/clickbar/mine_clickbar.dart';
import 'package:lighthouse/ui/widget/common_scroll_view.dart';
import 'package:lighthouse/ui/widget/dialog/dialog_util.dart';
import 'package:lighthouse/utils/path_util.dart';
import 'package:lighthouse/utils/toast_util.dart';
import 'package:path_provider/path_provider.dart';

class MinePage extends StatefulWidget {

  const MinePage({
    Key key,
  }) : super(key : key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with BasePageMixin<MinePage>, AutomaticKeepAliveClientMixin<MinePage>, SingleTickerProviderStateMixin {

  @override
  bool get wantKeepAlive => true;

  StreamSubscription _userSubscription;

  @override
  void initState() {
    super.initState();

    _userSubscription = Event.eventBus.on<UserEvent>().listen((event) {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    if (_userSubscription != null) {
      _userSubscription.cancel();
    }

    super.dispose();
  }

  void _logout() {
    DialogUtil.showCupertinoAlertDialog(context,
      title: S.of(context).logout,
      content: S.of(context).logoutConfirm,
      cancel: S.of(context).cancel,
      confirm: S.of(context).confirm,
      cancelPressed: () => Navigator.of(context).pop(),
      confirmPressed: () {
        Navigator.of(context).pop();
        RTAccount.instance().logout();
      }
    );
  }

  Future<void> _clearCache() async {
    Directory cacheDir = await getTemporaryDirectory();
    double cacheSize = await PathUtils.getTotalSizeOfFilesInDir(cacheDir);
    if (cacheSize > 0) {

      DialogUtil.showCupertinoAlertDialog(context,
        title: S.of(context).clearCache,
        content: S.of(context).cacheSize + PathUtils.renderSize(cacheSize) + S.of(context).clearCacheConfirm,
        cancel: S.of(context).cancel,
        confirm: S.of(context).confirm,
        cancelPressed: () => Navigator.of(context).pop(),
        confirmPressed: () async {
          Navigator.of(context).pop();
          await PathUtils.delDir(cacheDir);
          ToastUtil.normal(S.of(context).clearCacheSuccess);
        }
    );

    } else {
      ToastUtil.normal(S.of(context).clearCacheSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Account account = RTAccount.instance().getActiveAccount();
    return Scaffold(
        backgroundColor: Colours.normal_bg,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colours.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 10,
        ),
        body: Stack(
          children: <Widget>[
            MineAppBar(
              account: account,
              onPressed: () => Routers.loginGuardNavigateTo(context, Routers.settingPage),
              onActionPressed: () => ToastUtil.normal('点鸡 通知'),
              onAvatarPressed: () => Routers.loginGuardNavigateTo(context, Routers.settingPage),
            ),

            Padding(
              padding: EdgeInsets.only(top: 110),
              child: CommonScrollView(
                  children: <Widget>[
                    Gaps.vGap18,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        boxShadow: BoxShadows.normalBoxShadow,
                      ),
                      child: Column(
                        children: [
                          MineClickBar(
                              title: S.of(context).accountSecurity,
                              icon: Icon(Icons.security, color: Colours.gray_350, size: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(14.0))),
                              onPressed: () => Routers.loginGuardNavigateTo(context, Routers.settingPage),
                          ),
                          MineClickBar(
                              title: S.of(context).clearCache,
                              icon: Icon(Icons.cleaning_services, color: Colours.gray_350, size: 20),
                              onPressed: _clearCache
                          ),
                          MineClickBar(
                              title: S.of(context).share,
                              icon: Icon(Icons.share, color: Colours.gray_350, size: 20),
                              onPressed: () => DialogUtil.showShareDialog(context)
                          ),
                          MineClickBar(
                              title: S.of(context).checkUpdate,
                              icon: Icon(Icons.update, color: Colours.gray_350, size: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(14.0))),
                              onPressed: () => FlutterBugly.checkUpgrade()
                          ),
                        ],
                      ),
                    ),

                    Gaps.vGap18,

                    RTAccount.instance().isLogin() ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        boxShadow: BoxShadows.normalBoxShadow,
                      ),
                      child: FlatButton(
                          onPressed: () => _logout(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: double.infinity,
                              child: Text(S.of(context).logout,
                                style: TextStyles.textRed_w400_15,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                          )
                      ),
                    ) : Gaps.empty


                  ]
              ),
            )

          ],
        )
    );
  }

}
