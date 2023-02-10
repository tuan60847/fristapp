import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fristapp/models/englishtoday.dart';
import 'package:fristapp/values/app_assets.dart';
import 'package:fristapp/values/app_color.dart';
import 'package:fristapp/values/app_styles.dart';

// class AllWordsPage extends StatelessWidget {
//    final List<EnglishToday> word;
//   const AllWordsPage({Key? key,required this.word}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.SecondPrimary ,
//       appBar: AppBar(
//         backgroundColor: AppColor.SecondPrimary,
//         // tắt đường line
//         elevation: 0,
//         title: Text('Show More',
//             style: AppStyles.h3.copyWith(color: AppColor.textColor, fontSize: 36,fontWeight: FontWeight.bold)
//         ),
//         leading: InkWell(
//           onTap: () async{
//             Navigator.pop(context);
//           },
//           child: Image.asset(AppAssets.leftArrow),
//           // child: Image.asset("assets/images/3x/icons8-back-arrow.png"),
//         ) ,
//       ),
//       // GridView.count dùng để sử dụng dữ liệu theo grid view cột chạy từ trên xuống
//       body: Container(
//         //padding: EdgeInsets.symmetric(horizontal: 8),
//         // child: GridView.count(
//         //   crossAxisCount: 2,
//         //   mainAxisSpacing: 8,
//         //   crossAxisSpacing: 8,
//         //   children: word.map((e) => Container(
//         //     alignment: Alignment.center,
//         //     decoration: BoxDecoration(
//         //       color: AppColor.primaryColor,
//         //       borderRadius: BorderRadius.all(Radius.circular(8))
//         //     ),
//         //     child: AutoSizeText(
//         //       e.noun??" ",
//         //       maxLines: 1,
//         //       overflow: TextOverflow.fade,
//         //       style: AppStyles.h3.copyWith(
//         //         shadows: [
//         //           BoxShadow(
//         //             color: Colors.black38,
//         //             offset: Offset(1,4),
//         //             blurRadius: 6,
//         //           )
//         //         ]
//         //       ),
//         //     ),
//         //   )).toList(),
//         // ),
//         child: ListView.builder(
//           itemCount: word.length,
//           itemBuilder: (context,index){
//             return InkWell(
//               onDoubleTap: () async {
//                 word[index].isFavorite=word[index].isFavorite!?false:true;
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(6)),
//                   color: index%2==0?AppColor.SecondPrimary:AppColor.primaryColor,
//                 ),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.all(16),
//                   title: Text(word[index].noun!,
//                   style: AppStyles.h4.copyWith(color: index%2==0?AppColor.textColor:AppColor.backGray),
//                   ),
//                   subtitle: Text(word[index].quete??""),
//                   leading: Icon(Icons.favorite,
//                     color:word[index].isFavorite!?Colors.red:AppColor.lightGray,
//
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       )
//       );
//   }
// }

class AllWordPage extends StatefulWidget {
  final List<EnglishToday> word;
  const AllWordPage({Key? key, required this.word}) : super(key: key);

  @override
  State<AllWordPage> createState() => _AllWordPageState();
}

class _AllWordPageState extends State<AllWordPage> {
  late List<EnglishToday> words=widget.word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.SecondPrimary ,
        appBar: AppBar(
          backgroundColor: AppColor.SecondPrimary,
          // tắt đường line
          elevation: 0,
          title: Text('Show More',
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
        // GridView.count dùng để sử dụng dữ liệu theo grid view cột chạy từ trên xuống
        body: Container(
          //padding: EdgeInsets.symmetric(horizontal: 8),
          // child: GridView.count(
          //   crossAxisCount: 2,
          //   mainAxisSpacing: 8,
          //   crossAxisSpacing: 8,
          //   children: word.map((e) => Container(
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: AppColor.primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(8))
          //     ),
          //     child: AutoSizeText(
          //       e.noun??" ",
          //       maxLines: 1,
          //       overflow: TextOverflow.fade,
          //       style: AppStyles.h3.copyWith(
          //         shadows: [
          //           BoxShadow(
          //             color: Colors.black38,
          //             offset: Offset(1,4),
          //             blurRadius: 6,
          //           )
          //         ]
          //       ),
          //     ),
          //   )).toList(),
          // ),
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context,index){
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: index%2==0?AppColor.SecondPrimary:AppColor.primaryColor,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(words[index].noun!,
                    style: AppStyles.h4.copyWith(color: index%2==0?AppColor.textColor:AppColor.backGray),
                  ),
                  subtitle: Text(words[index].quete??""),
                  leading: InkWell(
                    onDoubleTap: () async {
                      setState(() {
                        words[index].isFavorite=words[index].isFavorite!?false:true;
                      });

                    },
                    child: Icon(Icons.favorite,
                      color:words[index].isFavorite!?Colors.red:AppColor.lightGray,

                    ),
                  ),
                ),
              );
            },
          ),
        )
    );;
  }
}



