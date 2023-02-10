
import 'package:flutter/material.dart';
import 'package:fristapp/pages/home_page.dart';
import 'package:fristapp/values/app_assets.dart';
import 'package:fristapp/values/app_color.dart';
import 'package:fristapp/values/app_font.dart';
import 'package:fristapp/values/app_styles.dart';

// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LadingPage(),
//     );
//   }
// }
class LadingPage extends StatelessWidget {
  const LadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16),
        child: Column(

          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,

                child: Text('Wecome To the App',
                  style: AppStyles.h3
                ),
              ),
            ),
             Expanded(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'English',
                      style: AppStyles.h2.copyWith(color: AppColor.backGray
                      ,fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(
                        'Quests',
                        style: AppStyles.h4.copyWith(height: 0.5),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
            ),
             Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom:64 ),
                child: RawMaterialButton(
                  onPressed: (){
                    //Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()) );
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                  },
                  fillColor: AppColor.lightBlue,
                  shape: CircleBorder(),
                  //assets/images/3x/icons8-next-page.png
                  //assets/images/3x/icons8-next-page.png
                  child: Image.asset(AppAssets.rightArrow),

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
