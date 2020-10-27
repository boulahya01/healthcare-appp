import 'package:flutter/cupertino.dart';
import 'package:flutter_healthcare_app/src/model/available.dart';
import 'package:flutter_healthcare_app/src/model/doctor.dart';
import 'package:flutter_healthcare_app/src/model/lab_test_by_category.dart';
import 'package:flutter_healthcare_app/src/model/lab_test_category.dart';
import 'package:flutter_healthcare_app/src/model/registration_response.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LabTestViewModel extends ChangeNotifier {

  Future<List<LabTestCategory>> getAllLabtest() async {
    final response =
        await http.get('http://172.16.61.221:8059/admins.asmx/getLabtestCat');

    if (response.statusCode == 200) {
      List<LabTestCategory> labTests;

      Iterable list = json.decode(response.body);
      labTests = list.map((model) => LabTestCategory.fromJson(model)).toList();
      return labTests;
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }

  Future<List<LabTestByCategory>> getLabTestByCategory(String testId) async {
    final response =
        await http.get('http://172.16.61.221:8059/admins.asmx/getLabtestbyCat?TestCategoryId=$testId');

    if (response.statusCode == 200) {
      List<LabTestByCategory> labTests;

      Iterable list = json.decode(response.body);
      labTests = list.map((model) => LabTestByCategory.fromJson(model)).toList();
      return labTests;
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }

  Future<RegistrationResponse> saveLabTest(String testId,String testCatId, String testFor,String testAmount,
      String sampleCollectDate,String sampleCollectTime,String paymentType) async {
    final response = await http.get(
        'http://172.16.61.221:8059/admins.asmx/userSaveLabTest?testId=$testId&userid=$testFor&testCatId=$testCatId&testFor=$testFor&testAmount=$testAmount'
            '&sampleCollectDate=$sampleCollectDate&sampleCollectTime=$sampleCollectTime&paymentType=$paymentType'
            );

    print(response.body);
    if (response.statusCode == 200) {
      return RegistrationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }






}
