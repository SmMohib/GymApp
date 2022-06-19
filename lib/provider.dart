import 'package:flutter/material.dart';
import 'package:gymapp/Model/Model.dart';
import 'package:gymapp/Model/Model.dart';
import 'package:provider/provider.dart';

class GymProvider with ChangeNotifier {
  List<ExerciesModel> gymList = [];
  late ExerciesModel exerciesModel;

  // getGym() async {
  //   gymList = await CustomHttpRequest().getAllGym();
  //   notifyListeners();
  // }
}
