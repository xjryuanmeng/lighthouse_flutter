
import 'package:flutter/material.dart';
import 'package:lighthouse/generated/l10n.dart';
import 'package:lighthouse/net/model/account.dart';
import 'package:lighthouse/res/colors.dart';
import 'package:lighthouse/res/styles.dart';
import 'package:lighthouse/ui/module_base/widget/image/circle_image.dart';

class MineAppBar extends StatefulWidget {

  final Account account;
  final VoidCallback onPressed;
  final VoidCallback onActionPressed;
  final VoidCallback onAvatarPressed;

  const MineAppBar({
    Key key,
    this.account,
    this.onPressed,
    this.onActionPressed,
    this.onAvatarPressed
  }): super(key: key);


  @override
  _MineAppBarState createState() => _MineAppBarState();
}

class _MineAppBarState extends State<MineAppBar> {


  @override
  Widget build(BuildContext context) {

    String title = widget.account != null ? widget.account.nick_name : S.of(context).loginNow;
    String subTitle = widget.account != null ? widget.account.phoneSecret : S.of(context).loginGuide;

    return InkWell(
        onTap: widget.onPressed,
        child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.vertical(bottom:  Radius.circular(16.0)),
              boxShadow: BoxShadows.normalBoxShadow,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 5,
                  child: IconButton(
                    onPressed: widget.onActionPressed,
                    padding: EdgeInsets.only(right: 10, top: 0, left: 10, bottom: 20),
                    icon: Icon(Icons.notifications, color: Colours.black, size: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 28),
                          child: InkWell(
                            onTap: widget.onAvatarPressed,
                            child: CircleImage(
                                widget.account?.head_ico,
                                radius: 32,
                                borderWidth: 3,
                                borderColor: Colours.white,
                                boxShadow: BoxShadows.normalBoxShadow,
                            ),
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            padding: EdgeInsets.only(left: 15, top: 10),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(bottom: 6),
                                    alignment: Alignment.centerLeft,
                                    child: Text(title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.textGray800_w400_17)
                                ),

                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(subTitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.textGray400_w400_14)
                                ),

                              ],
                            )),
                      ),

                      IconButton(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        icon: Icon(Icons.keyboard_arrow_right, color: Colours.gray_200, size: 25),
                      ),

                    ],
                  ),
                ),

              ],
            )
        )
    );
  }
}
