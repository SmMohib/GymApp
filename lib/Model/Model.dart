import 'package:flutter/material.dart';

class ExerciesModel {
  String? id, title, thumbnail, gif, seconds;
  ExerciesModel? exerciesModel;

  ExerciesModel(
      {this.gif,
      this.id,
      this.seconds,
      this.thumbnail,
      this.exerciesModel,
      this.title});

  static fromJson(data) {}
}
