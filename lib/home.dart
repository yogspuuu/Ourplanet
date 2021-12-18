import 'package:ourplanet/data.dart';
import 'package:ourplanet/item.dart';
import 'package:ourplanet/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int planetIndex = 2;
  final ScrollController _scrollController = ScrollController();

  double bgPosition() {
    if (_scrollController.hasClients) {
      return _scrollController.offset * -1 / 4;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    // _scrollController.addListener(() {
    //   print(_scrollController.offset);
    // });

    PlanetData.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: <Widget>[
            AnimatedBuilder(
              animation: _scrollController,
              builder: (ctx, widget) {
                return Positioned(
                  right: bgPosition(),
                  child: Hero(
                    tag: 'bg' + planetIndex.toString(),
                    child: Image.asset(
                      'assets/bg.png',
                      alignment: Alignment.centerLeft,
                      height: size.height,
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header(),
                  planets(context),
                  description(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Our Planet',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(32),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: ScreenUtil().setWidth(18),
            ),
            Text(
              'Mengenal nama Planet di Tatasurya',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget planets(BuildContext context) {
    return Expanded(
      flex: 3,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: ScrollSnapList(
          padding: const EdgeInsets.all(0),
          itemSize: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.all(0),
          onItemFocus: (index) {
            setState(() {
              planetIndex = index;
            });
          },
          itemCount: 8,
          dynamicItemSize: true,
          initialIndex: 2,
          scrollDirection: Axis.horizontal,
          listController: _scrollController,
          curve: Curves.ease,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DetailScreen(
                      index: planetIndex,
                      bgPosition: bgPosition(),
                    );
                  }),
                );
              },
              child: PlanetItem(
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget description() {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      flex: 2,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(12),
            ),
            Text(
              PlanetData.planets[planetIndex].name,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(32),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: ScreenUtil().setWidth(62),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailScreen(
                        index: planetIndex,
                        bgPosition: bgPosition(),
                      );
                    },
                  ),
                );
              },
              child: Container(
                height: size.width / 6,
                width: size.width / 6,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.up_arrow,
                    color: Colors.white,
                    size: size.width / 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
