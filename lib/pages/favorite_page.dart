import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fristapp/models/englishtoday.dart';
import 'package:fristapp/values/app_assets.dart';
import 'package:fristapp/values/app_color.dart';
import 'package:fristapp/values/app_styles.dart';

class FavoritePage extends StatefulWidget {
  final List<EnglishToday> words;
  const FavoritePage({Key? key, required this.words}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<EnglishToday> words = widget.words;
  late List<EnglishToday> FavoriteWord=[];
  getFavorite(){
    words.forEach((element) {
      if(element.isFavorite==true){
        FavoriteWord.add(element);
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavorite();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.SecondPrimary ,
      appBar: AppBar(
        backgroundColor: AppColor.SecondPrimary,
        // tắt đường line
        elevation: 0,
        title: Text('Favorite Page',
            style: AppStyles.h3.copyWith(color: AppColor.textColor, fontSize: 36,fontWeight: FontWeight.bold)
        ),
        leading: InkWell(
          onTap: () async{
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
          // child: Image.asset("assets/images/3x/icons8-back-arrow.png"),
        ) ,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: FavoriteWord.map((e) => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),

            ),
            child: AutoSizeText(
              e.noun??" ",
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: AppStyles.h3.copyWith(
                shadows: [
                  BoxShadow(color: Colors.black38,offset: Offset(1,4),blurRadius: 6)
                ]
              ),

            ),
          )
          ).toList()

        ),
      ),
    );
  }
}

