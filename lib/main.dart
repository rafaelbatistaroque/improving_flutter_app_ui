import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectratio = cardAspectRatio * 1.2;

class _MyAppState extends State<MyApp> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: images.length - 1);
    pageController.addListener((){
      setState(() {
        currentPage = pageController.page;
      });
    });
    return Scaffold(
      backgroundColor: Color(0xFF2D3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: (){},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: (){},
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Melhores",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46.0,
                      letterSpacing: 1.0
                    )),
                    IconButton(
                      icon: Icon(Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: (){},
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 22.0),
                        child: Text("Fantasy",
                        style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Text("25+ Stories", style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: images.length,
                    controller: pageController,
                    reverse: true,
                    itemBuilder: (context, index){
                      return Container();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
class CardScrollWidget extends StatelessWidget {
final double currentPag;
final double padding = 20.0;
final double verticalInset = 20.0;

CardScrollWidget(this.currentPag);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectratio,
      child: LayoutBuilder(
        builder: (context, contraints){
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;
          
          List<Widget> cardList = List();

          for(var i = 0; i < images.length; i++) {
            var delta = i - currentPag;
            bool isOnRight = delta > 0;

            var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);
            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0
                      )
                    ]
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(images[i], fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text(title[i], style: TextStyle(color: Colors.white, fontSize: 25.0)),
                              ),
                              SizedBox(height: 10.0,),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text("Leia depois", style: TextStyle(color: Colors.white),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
            );
        }
      ),
    );
  }
}