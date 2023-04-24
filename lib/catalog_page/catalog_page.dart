import 'package:animate_do/animate_do.dart';
import 'package:cookies_app/data.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool initAnimation = false;

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
        width: double.infinity,
        height: double.infinity,
        duration: const Duration(milliseconds: 500),
        decoration: initAnimation
            ? const BoxDecoration(color: Color(0xFF26282A))
            : const BoxDecoration(color: Color(0xFFDDC6F9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopAppBar(),
            Flexible(
              flex: 1,
              child: const Text(
                'Catalog',
                style: TextStyle(
                    fontFamily: 'Pacifico', color: Colors.white, fontSize: 60),
              ),
            ),
            Spacer(),
            Flexible(flex: 4, child: SingleChildScrollView(child: createTable())),
          ],
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
    return Flexible(
      flex: 1,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 60,
              height: 80,
              right: 30,
              left: 30,
              child: Row(
                children: [
                  Container(color: Colors.red,),
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
                        height: 40,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CookieCard extends StatelessWidget {
  const CookieCard({Key? key, required this.cookie}) : super(key: key);

  final Cookies cookie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(cookie.image),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cookie.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text('${cookie.weight} gr'),
                ],
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.deepPurple,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget createTable() {
  List<TableRow> rows = [];
  for (int i = 0; i < cookies.length / 2; ++i) {
    rows.add(TableRow(children: [
      CookieCard(
        cookie: cookies[i],
      ),
      CookieCard(
        cookie: cookies[i + 1],
      ),
    ]));
  }
  return Table(children: rows);
}
