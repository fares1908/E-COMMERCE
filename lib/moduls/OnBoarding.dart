
import 'package:ShopApp/moduls/Login/Login_Screen.dart';
import 'package:ShopApp/network/network.local.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
void navigatAndfinshed(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

class BoardingModel {
  late final String image;
  late final String title;
  BoardingModel({
    required this.image,
    required this.title,

  });
}

class onBoardingScreen extends StatefulWidget {


  @override

  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardControllar = PageController();
  bool isLast = false;
  void submit(){
    CashHelper.saveData(key: 'onBoarding', value: true).then(
            (value){
              if(value=true){
                navigatAndfinshed(context, LoginScreen());
              }
            });
  }
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/onBorder1.jpg',
      title: 'Give your products to one who actually need it rather than selling/throwing it',

    ),
    BoardingModel(
      image: 'assets/onBorder2.jpg',
      title: 'Door-Door delivery is not something that you need to worry about. Well take care of delivery',
    ),
    BoardingModel(
      image: 'assets/onBorder3.jpg',
      title: 'We are here you to take care of your product sharing and donation.',

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                  fontSize: 15,
                ),
              ),
              onTap: () {
              submit();
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('the last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    print(index);
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardControllar,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardControllar,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: Colors.orangeAccent,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      boardControllar.nextPage(
                        duration: Duration(milliseconds: 50),
                        curve: Curves.bounceInOut,
                      );
                    }
                  },
                  child: Icon(
                   Icons.arrow_forward_ios
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        model.title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
