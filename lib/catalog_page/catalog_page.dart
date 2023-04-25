import 'package:animate_do/animate_do.dart';
import 'package:cookies_app/data.dart';
import 'package:cookies_app/details_page/details_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool initAnimation = false;
  bool initCookiesGrid = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      initAnimation = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        onEnd: () {
          Future.delayed(Duration(milliseconds: 500), () {
            initCookiesGrid = true;
          });
        },
        width: double.infinity,
        height: double.infinity,
        duration: const Duration(milliseconds: 500),
        decoration: initAnimation
            ? const BoxDecoration(color: Color(0xFF26282A))
            : const BoxDecoration(color: Color(0xFFDDC6F9)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 65, 20, 0),
          child: Column(
            children: [
              const TopAppBar(),
              const Text(
                'Catalog',
                style: TextStyle(
                    fontFamily: 'Pacifico', color: Colors.white, fontSize: 60),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  child: createTable(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeInLeft(
          child: Spin(
            spins: 1,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 37,
              child: CircleAvatar(
                radius: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(kAvatarPicture),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        FadeInRight(
          child: Spin(
            spins: 1,
            child: Image.asset(
              kMenuIcon,
              height: 50,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class CookieCard extends StatelessWidget {
  const CookieCard({Key? key, required this.cookie, required this.i}) : super(key: key);
final int i;
  final Cookies cookie;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizeAddButton = size.height * 0.05;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DetailsPage(cookie: cookie)),
        );
      },
      child: ZoomIn(
        duration: Duration(milliseconds: (i + 1) * 400),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: size.height * 0.28,
          width: size.width * 0.28,
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.04),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Hero(
                tag: cookie.image,
                child: Image.asset(
                  cookie.image,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cookie.name,
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('${cookie.weight} gr'),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    height: sizeAddButton,
                    width: sizeAddButton,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kCustomPurpleColor,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


Widget createTable() {
  List<TableRow> rows = [];
  for (int i = 0; i < cookies.length - 1; i = i + 2) {
    rows.add(TableRow(children: [
      CookieCard(
        cookie: cookies[i],
        i: i,
      ),
      CookieCard(
        cookie: cookies[i + 1],
        i: i,
      ),
    ]));
  }
  return Table(children: rows);
}
