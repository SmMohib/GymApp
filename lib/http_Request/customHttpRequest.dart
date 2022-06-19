// import 'dart:convert';
// import 'dart:io';

// import 'package:gymapp/Model/Model.dart';
// import 'package:gymapp/provider.dart';
// import 'package:http/http.dart' as http;

// class CustomHttpRequest {
//   Future<dynamic> getAllOrders() async {
//     List<ExerciesModel> orderList = [];
//     late ExerciesModel orderModel;

//     var responce = await http.get(
//       Uri.parse('Link'),
//       // headers: await CustomHttpRequest().getHeaderWithToken()
//     );
//     if (responce.statusCode == 200) {
//       var item = jsonDecode(responce.body);
//       print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$item");
//       for (var data in item) {
//         var exerciesModel = ExerciesModel.fromJson(data);

//         orderList.add(exerciesModel);
//       }
//       print("total order is ${orderList.length}");
//     }

//     return orderList;
//   }
// }
