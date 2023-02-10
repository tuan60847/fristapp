
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';


import 'package:flutter/material.dart';
import 'package:fristapp/models/englishtoday.dart';
import 'package:fristapp/packages/quote.dart';
import 'package:fristapp/packages/quote_model.dart';
import 'package:fristapp/pages/all_words_page.dart';
import 'package:fristapp/pages/cotrol_page.dart';
import 'package:fristapp/pages/favorite_page.dart';
import 'package:fristapp/values/app_assets.dart';
import 'package:fristapp/values/app_color.dart';
import 'package:fristapp/values/app_font.dart';
import 'package:fristapp/values/app_styles.dart';
import 'package:fristapp/values/share_keys.dart';
import 'package:fristapp/widgets/app_button.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<EnglishToday>words =[];
  String quote = Quotes().getRandom().content!;

  List<int> fixedLIstRandom({int len = 1,int max = 128,int min = 1}){
    if(len>max|| len<min){
      return  [];
    }
    List<int> newList= [];

    Random random = Random();
    int count = 1;
    while(count<=len){
      int val = random.nextInt(max);
      if(newList.contains(val)){
        continue;
      }
      else{
        newList.add(val);
        count++;
      }
    }

    return newList;
  }
  // getEnlishToday
  getEngishToday() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter)??5;
    List<String> newList = [];
    List<int> rans = fixedLIstRandom(len: len, max: nouns.length,min: 1);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });

  }

  EnglishToday getQuote(String noun){
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(noun: noun,
      quete: quote?.content,
      id: quote?.id
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);

    super.initState();
    getEngishToday();
  }
  @override
  Widget build(BuildContext context) {
    // lấy Kích thước của màn hình
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.SecondPrimary,
      appBar: AppBar(
        backgroundColor: AppColor.SecondPrimary,
        // tắt đường line
        elevation: 0,
        title: Text('English today',
          style: AppStyles.h3.copyWith(color: AppColor.textColor, fontSize: 36,fontWeight: FontWeight.bold)
        ),
        leading: InkWell(
        onTap: (){
          _scaffoldKey.currentState?.openDrawer();
        },
          child: Image.asset(AppAssets.menu),
        ) ,
      ),
      body: Container(
        width: double.infinity,
        //margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              height: size.height /10,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: Text(
                '"$quote"',
                style: AppStyles.h3.copyWith(fontSize: 14, color: AppColor.textColor),
              ),
            ),
            Container(
              height: size.height*2/3,
              // padding: const EdgeInsets.all(16),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _currentIndex=index;
                  });
                },
                // itemCount là số lượng trang
                  itemCount: words.length>5?6:words.length,
                  itemBuilder: (context , index){
                  String Letter = words[index].noun!=null?words[index].noun!:' ';
                  String FirstLetter = Letter.substring(0,1);
                  String LaterLetter = Letter.substring(1,Letter.length);
                  String quoteDefault = 'Think of all the beautiful still left around and be happy';
                  String quote = words[index].quete != null? words[index].quete!:quoteDefault;


                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: AppColor.primaryColor,
                        elevation: 4,
                        child: InkWell(
                          onDoubleTap: (){
                            setState(() {
                              words[index].isFavorite=words[index].isFavorite==true?false:true;

                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: index>=5?
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AllWordPage(word: this.words)));
                              },
                              child: Center(
                                child: Container(
                                  child: Text("Show More",
                                    style: AppStyles.h3.copyWith(
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          offset:  Offset(3,4),
                                          blurRadius: 6
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            )
                                :Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LikeButton(
                                  onTap:(bool isLiked) async{
                                    setState(() {
                                      words[index].isFavorite=words[index].isFavorite!?false:true;
                                    });
                                    return  words[index].isFavorite;

                                  },
                                  isLiked: words[index].isFavorite,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  size: 42,
                                  circleColor:
                                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return ImageIcon(
                                      AssetImage(AppAssets.heart),
                                      color: isLiked ? Colors.red : Colors.white,
                                      size: 42,
                                    );
                                  },
                                ),

                                // Container(
                                //     child: Image.asset(AppAssets.heart,
                                //       color: words[index].isFavorite==true?Colors.red:Colors.white,),
                                //   alignment: Alignment.centerRight,
                                //   padding: const EdgeInsets.only(top: 12, right: 12),
                                // ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis ,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: FirstLetter,
                                    style: TextStyle(
                                      fontFamily: FontFamily.sen,
                                      fontSize: 89,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                          color: AppColor.textGray,
                                          offset:  Offset(3,6),
                                        )
                                      ]
                                    ),
                                    children: [
                                      TextSpan(text: LaterLetter,
                                        style: TextStyle(

                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                color: AppColor.textGray,
                                                offset:  Offset(3,6),
                                              )
                                            ]
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24,right: 16),

                                  child: AutoSizeText(
                                    '"$quote"',
                                    maxFontSize: 26,
                                    maxLines: 9,
                                    style: AppStyles.h4.copyWith(
                                      color: AppColor.textColor,
                                      letterSpacing: 1,
                                    ) ,
                                  ),
                                )
                              ],
                            ),
                          ),

                          splashColor: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                      ),
                    );
              }
              ),
            ),
            //indicator
            _currentIndex>=5?buildShowMore():
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: size.height*1/12,

                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: ListView.builder(
                    // không cho xem hoặc lướt trang
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal ,
                    itemCount: 5,
                      itemBuilder: (context,index){
                      return buildIndicator(index==_currentIndex,size);
                      },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed:(){
          setState(() {
            getEngishToday();
          });
        } ,
        child: Image.asset(AppAssets.loading) ,
        backgroundColor: AppColor.primaryColor,
      ),
      drawer: Drawer(
        child: Container(
          color: AppColor.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Your mind',
                  style: AppStyles.h3.copyWith(color: AppColor.textColor,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: AppButton(label: 'Favorite', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage(words: words)));
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: AppButton(label: 'Your Control', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ControlPage()));
                }),
              ),
            ],
          ),
        ),
      ),
    );

  }
  Widget buildIndicator(bool isActive,Size size){
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 12,
      width: isActive ? size.width*1/5:24,
      decoration: BoxDecoration(
        color: isActive ? AppColor.lightBlue:AppColor.lightGray,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(2,3),
            blurRadius: 3,

          )
        ]
      ),
    );
  }

  Widget buildShowMore(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
      alignment: Alignment.centerLeft,
      // color: Colors.red,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: AppColor.primaryColor,
        elevation: 5,
        child: InkWell(
          onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AllWordPage(word: this.words)));
            // print("object");
          },
          splashColor: Colors.black38,
          //overlayColor: MaterialStateProperty.all(Colors.amber),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          child: Container(

            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            child: Text("Show more",style: AppStyles.h5.copyWith(color: AppColor.textColor),),
          ),
        ),
      ),
    );
  }
}
