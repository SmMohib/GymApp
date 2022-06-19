import 'dart:convert';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gymapp/addpage.dart';
import 'package:gymapp/http_Request/customHttpRequest.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gymapp/DetailPage.dart';
import 'package:gymapp/Model/Model.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GridDemo extends StatefulWidget {
  const GridDemo({Key? key}) : super(key: key);

  @override
  State<GridDemo> createState() => _GridDemoState();
}

class _GridDemoState extends State<GridDemo> {
  //ad
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  //end ad
  //api
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR1GLJ073KwOsgAxkIRiZq2GnNS-Z3TROR8jpv3cwvtjpBxOSqAwphf8tpU";

  List<ExerciesModel> allData = [];
  late ExerciesModel exerciesModel;

  bool isLoading = false;

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    var responce = await http.get(Uri.parse(link));
    print("status code is ${responce.statusCode}");
    print("${responce.body}");
    if (responce.statusCode == 200) {
      final item = jsonDecode(responce.body);
      for (var data in item["exercises"]) {
        exerciesModel = ExerciesModel(
            id: data["id"],
            gif: data["gif"],
            seconds: data["seconds"],
            thumbnail: data["thumbnail"],
            title: data["title"]);
        setState(() {
          allData.add(exerciesModel);
        });
      }

      print("total length is ${allData.length}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    //banner ad
    super.initState();
    _createBottomBannerAd();
    // TODO: implement initState
    fetchData();
    /* Future.delayed(Duration(seconds: 3), () {
     
    });*/
    super.initState();
  }
//eng api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom ad
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: double.infinity,
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      backgroundColor: Color.fromARGB(223, 255, 255, 255),
      body: Container(
          child: GridView.builder(
        itemCount: allData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetilPage(
                        exerciesModel: allData[index],
                      )));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Image.network(
                      "${allData[index].gif}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 80,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "${allData[index].title}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.black12,
                                Colors.black54,
                                Colors.black87,
                                Colors.black
                              ])),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
