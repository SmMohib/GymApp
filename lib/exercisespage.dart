import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gymapp/Model/Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gymapp/addpage.dart';

class ExercisesPage extends StatefulWidget {
  ExerciesModel? exerciesModel;
  String? id, title, thumbnail, gif;

  int? second;

  ExercisesPage(
      {Key? key,
      this.exerciesModel,
      this.gif,
      this.id,
      this.second,
      this.thumbnail,
      this.title})
      : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool isPlyaing = false;
  bool isComplite = false;
  int startSound = 0;
  String audioPath = 'audio.mp3';
  late Timer timer;
  void playAudio() async {
    await audioCache.play(audioPath);
    print('playing');
  }

  @override
  void initState() {
//ad
    super.initState();
    _createBottomBannerAd();
    //end

    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          isComplite == true;
          playAudio();
          Navigator.of(context).pop();
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      // appBar: AppBar(
      //   title: Text('${widget.title}'),
      // ),
      body: Stack(
        children: [
          // Image.network(
          //   '${widget.thumbnail}',
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          // ),
          Column(children: [
            SizedBox(
              height: 40,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: Image.network(
                  '${widget.gif}',
                  width: double.infinity,
                )),
            Text(
              'Time Start',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.blue,
              child: Text(
                '${startSound} / ${widget.second!.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("End Now"),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ],
      ),
    );
  }
}
