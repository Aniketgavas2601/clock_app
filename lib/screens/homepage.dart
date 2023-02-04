import 'package:clock_app/data.dart';
import 'package:clock_app/enum.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/screens/alarmpage.dart';
import 'package:clock_app/screens/clockpage.dart';
import 'package:clock_app/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2d2f41),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((currentMenuInfo) => buildMenuButton(currentMenuInfo)).toList()
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child){
                if(value.menuType == MenuType.clock)
                return ClockPage();
                else
                  return AlarmPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child){
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: currentMenuInfo.menuType == value.menuType
                  ? CustomColors.menuBackgroundColor
                  : Color(0xff2d2f41),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(32))
              )
            ),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context,listen: false);
              menuInfo.updateMenuInfo(currentMenuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource ?? '',
                  scale: 1.5,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  currentMenuInfo.title ?? '',
                  style: TextStyle(fontFamily: 'avenir',color: CustomColors.primaryTextColor, fontSize: 14),
                )
              ],
            ));
      },
    );
  }
}
