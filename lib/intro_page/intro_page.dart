import 'package:cookies_app/catalog_page/catalog_page.dart';
import 'package:cookies_app/constants.dart';
import 'package:cookies_app/data.dart';
import 'package:flutter/material.dart';
import 'package:marqueer/marqueer.dart';
import 'package:rive/rive.dart';
import 'dart:math' as math;

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController mainController;
  late Animation<double> mainAnimation;

  bool isBouncing = false;
  double value = 0;

  //late RiveAnimationController riveController;

  @override
  void initState() {
    super.initState();
    mainController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: kMainAnimationTime));
    mainAnimation = Tween<double>(begin: 0, end: kMainAnimationTime / 1000)
        .animate(CurvedAnimation(
      parent: mainController,
      curve: Curves.linear,
    ))
      ..addListener(() {
        if (mainAnimation.isCompleted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const CatalogPage()),
              (route) => false);
        }
        setState(() {
          value = mainAnimation.value;
          double windows = kMainAnimationTime / 1000 - 1;
          if (value > 1.0 && value <= windows) {
            value = 1;
          }
          if (value > windows) {
            value = kMainAnimationTime / 1000 - value;
          }
        });
      });
    Future.delayed(const Duration(milliseconds: 4000), () {
      isBouncing = true;
      mainController.forward();
      setState(() {});
    });
    /*riveController = OneShotAnimation(
      'bounce',
      autoplay: true
    );*/
  }

  @override
  void dispose() {
    mainController.dispose();
    //riveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontFreshCookies = 75;
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF26282A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CookiesTitle(height: height),
          const RiveAnimation.asset(
            'lib/assets/rives/bouncing.riv',
            fit: BoxFit.fitHeight,
          ),
          if (isBouncing)
            FreshCookiesTextMarquee(
                width: width,
                height: height,
                value: value.clamp(0, 1),
                fontFreshCookies: fontFreshCookies),
          Positioned(
            top: height / 2 + 100,
            bottom: 40,
            left: 140 * value - 250,
            width: width * 0.55,
            child: Transform.rotate(
                angle: -2 * math.pi * value,
                child: Image.asset('lib/assets/images/1.png')),
          ),
          Positioned(
            top: height * 0.25,
            bottom: 30,
            right: 140 * value - 250,
            width: width * 0.6,
            child: Transform.rotate(
                angle: 2 * math.pi * value,
                child: Image.asset('lib/assets/images/2.png')),
          )
        ],
      ),
    );
  }
}

class FreshCookiesTextMarquee extends StatelessWidget {
  const FreshCookiesTextMarquee({
    super.key,
    required this.width,
    required this.height,
    required this.fontFreshCookies,
    required this.value,
  });

  final double width;
  final double height;
  final double value;
  final double fontFreshCookies;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: width,
      top: height / 2 + 55,
      bottom: 10,
      child: Opacity(
        opacity: value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Marqueer(
                direction: MarqueerDirection.rtl,
                child: Text(
                  'Fresh cookies ',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: const Color(0xFFE9D8FC),
                      fontSize: fontFreshCookies),
                ),
              ),
            ),
            Expanded(
                child: Marqueer(
              direction: MarqueerDirection.ltr,
              child: Text(
                'Fresh cookies ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: const Color(0xFFE9D8FC),
                    fontSize: fontFreshCookies),
              ),
            )),
            Expanded(
                child: Marqueer(
              direction: MarqueerDirection.rtl,
              child: Text(
                'Fresh cookies ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: const Color(0xFFE9D8FC),
                    fontSize: fontFreshCookies),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class CookiesTitle extends StatelessWidget {
  const CookiesTitle({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * 0.12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Cookies',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 70.0,
              color: Color(0xFFC7FF7F),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Fresh cookies from the\noven to your home',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
