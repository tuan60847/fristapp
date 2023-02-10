import 'package:flutter/material.dart';
import 'package:fristapp/values/app_color.dart';
import 'package:fristapp/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_assets.dart';
import '../values/app_styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late int a = 5;
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefaultValue();
  }
  initDefaultValue() async{
  prefs = await SharedPreferences.getInstance();

  int value = prefs.getInt(ShareKeys.counter)??5;
  setState(() {
    sliderValue = value.toDouble();
    a= value;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.SecondPrimary ,
      appBar: AppBar(
        backgroundColor: AppColor.SecondPrimary,
        // tắt đường line
        elevation: 0,
        title: Text('Your Control',
            style: AppStyles.h3.copyWith(color: AppColor.textColor, fontSize: 36,fontWeight: FontWeight.bold)
        ),
        leading: InkWell(
          onTap: () async{
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt());

            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
          // child: Image.asset("assets/images/3x/icons8-back-arrow.png"),
        ) ,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text("How much a number word at once",
              style: AppStyles.h4.copyWith(color: AppColor.lightGray,fontSize: 18,
              ),
            ),
            Spacer(),
            Text('$a',
              style: AppStyles.h1.copyWith(color: AppColor.primaryColor,fontSize: 150, fontWeight: FontWeight.bold
              ),
            ),
            Slider(
                value: sliderValue,
                min: 5,
                divisions: 95,
                max: 100,
                activeColor: AppColor.primaryColor,
                inactiveColor: AppColor.primaryColor,
                onChanged: (value) {
                  print('$value');
                  setState(() {
                    sliderValue = value;
                    a=sliderValue.toInt();
                  });
                }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.centerLeft,
              child: Text("Silde to set",
                style: AppStyles.h5.copyWith(color: AppColor.textColor,
                ),
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
