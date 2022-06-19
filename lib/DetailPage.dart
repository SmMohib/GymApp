import 'package:flutter/material.dart';
import 'package:gymapp/Model/Model.dart';
import 'package:gymapp/exercisespage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetilPage extends StatefulWidget {
  DetilPage({Key? key, this.exerciesModel}) : super(key: key);

  ExerciesModel? exerciesModel;

  @override
  State<DetilPage> createState() => _DetilPageState();
}

class _DetilPageState extends State<DetilPage> {
  double second = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black12,
      body: Stack(children: [
        SizedBox(
          height: 50,
        ),
        Image.network(
          "${widget.exerciesModel!.gif}",
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
        ),
        Positioned(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black12,
        )),
        Positioned(
          bottom: 20,
          right: 0,
          left: 0,
          child: Column(
            children: [
              SleekCircularSlider(
                innerWidget: (value) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${second.toStringAsFixed(0)} S",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                },
                appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(progressBarWidth: 15),
                    customColors: CustomSliderColors(
                      progressBarColor: Colors.red,
                    )),
                min: 3,
                max: 120,
                initialValue: second,
                onChange: (value) {
                  setState(() {
                    second = value;
                  });
                },
              ),
              MaterialButton(
                color: Colors.orange,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ExercisesPage(
                                title: widget.exerciesModel!.title,
                                gif: widget.exerciesModel!.gif,
                                second: second.toInt(),
                                thumbnail: widget.exerciesModel!.thumbnail,
                                // location: widget.model!.location,
                              ))));
                },
                child: Text("Start"),
              )
            ],
          ),
        )
      ]),
    );
  }
}
