import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view/background_clipper.dart';
import 'package:page_view/bottombar_clipper.dart';
import 'package:page_view/common/my_flutter_app_icons.dart';
import 'package:page_view/slide_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Color> _colorList = [Colors.orange, Colors.deepPurple, Colors.redAccent];
  List<int> _numList = [86, 92, 78];
  List<Set<String>> _nameList = [
    {'Flame', 'Gold Gnome', 'Victim flames'},
    {'Ice Diamond', 'Gnome', 'Cold kingdom'},
    {'Fire Ruby', 'Gnome', 'Fire lighting'},
  ];
  List<double> _scoreList = [9.4, 9.8, 7.8];
  List<String> _imageList = [
    'https://cdn.pixabay.com/photo/2016/08/23/18/50/spider-1615195_1280.png',
    'https://cdn.pixabay.com/photo/2016/09/10/11/42/quadrocopter-1658967_1280.png',
    'https://cdn.pixabay.com/photo/2017/01/03/17/04/dragon-1949993_1280.png',
  ];

  late AnimationController _animationController;
  late AnimationController slideController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );
  late Animation<double> animation;
  late Animation<double> numberAnimation;
  PageController _pageController = PageController();
  double? currentPageValue = 0.0;
  int? pageValue = 0;
  int? previousValue = 0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.slowMiddle);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
        if (_pageController.page?.round() == _pageController.page) {
          previousValue = pageValue;
          pageValue = _pageController.page?.round();
        }
      });
      if (_pageController.page?.round() == _pageController.page &&
          previousValue != pageValue) {
        _animationController.reset();
        _animationController.forward();
        slideController.reset();
        slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.removeListener(() {
      setState(() {
        currentPageValue = _pageController.page?.roundToDouble();
        if (pageValue != _pageController.page?.round()) {
          pageValue = _pageController.page?.round();
        }
      });
    });
    _animationController.dispose();
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _colorList[previousValue ?? 0],
            ),
          ),
          AnimatedBuilder(
            animation: CurvedAnimation(
                parent: _animationController, curve: Curves.bounceIn),
            builder: (context, child) {
              return ClipOval(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: _colorList[pageValue ?? 0],
                  ),
                ),
                clipper: BackgroundClipper(animation: animation.value),
              );
            },
          ),
          SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double? bodyHeight = constraints.maxHeight;
                double? bodyWidth = constraints.maxWidth;

                return Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Center(
                              child: Image(
                            image: NetworkImage(_imageList[index]),
                          )),
                        );
                      },
                    ),
                    Positioned(
                      top: 0,
                      left: bodyWidth / 8 - 26,
                      right: 0,
                      bottom: bodyHeight / 16 * 15,
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            size: 28,
                            color: Colors.white,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2021/04/13/06/59/woman-6174830_1280.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: bodyHeight / 16 + 16,
                      bottom: bodyHeight / 16 * 12,
                      left: bodyWidth / 8 - 20,
                      right: bodyWidth / 8 * 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: SlideContainer(
                              animationController: slideController,
                              oldChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _nameList[previousValue ?? 0].elementAt(0),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _nameList[previousValue ?? 0].elementAt(1),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _nameList[pageValue ?? 0].elementAt(0),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _nameList[pageValue ?? 0].elementAt(1),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            child: SlideContainer(
                              animationController: slideController,
                              oldChild: Text(
                                _nameList[previousValue ?? 0].elementAt(2),
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                ),
                              ),
                              child: Text(
                                _nameList[pageValue ?? 0].elementAt(2),
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: bodyHeight / 16 * 4,
                      bottom: bodyHeight / 16 * 11 - 15,
                      left: bodyWidth / 8 * 1 - 20,
                      right: bodyWidth / 8 * 6 + 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.black),
                            SizedBox(height: 4),
                            Text(
                              _scoreList[pageValue ?? 0].toString(),
                              style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: bodyHeight / 16 * 11 - 20,
                      left: 0,
                      right: 0,
                      bottom: bodyHeight / 16 * 3 + 20,
                      child: Column(
                        children: [
                          Text('Win rate',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100)),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return RichText(
                                text: TextSpan(
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 42,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  text: _animationController.value == 0
                                      ? '${_numList[pageValue ?? 0]}'
                                      : '${_numList[previousValue ?? 0] - (_animationController.value * (_numList[previousValue ?? 0] - _numList[pageValue ?? 0])).floor()}',
                                  children: <TextSpan>[
                                    TextSpan(text: '%'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      top: bodyHeight / 16 * 13,
                      bottom: bodyHeight / 16 * 3 - 30,
                      child: Center(
                        child: Icon(MyFlutterApp.skull,
                            size: 22, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipPath(
                        clipper: BottomBarCustomClipper(),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Let\'s Go",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 50,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 26,
                                        top: 0,
                                        child: Icon(
                                            Icons.keyboard_arrow_right_sharp,
                                            color: Colors.white,
                                            size: 28),
                                      ),
                                      Positioned(
                                        left: 13,
                                        top: 0,
                                        child: Icon(
                                            Icons.keyboard_arrow_right_sharp,
                                            color: Colors.grey,
                                            size: 28),
                                      ),
                                      Positioned(
                                        child: Icon(
                                            Icons.keyboard_arrow_right_sharp,
                                            color: Colors.grey.withAlpha(180),
                                            size: 28),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
