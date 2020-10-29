import 'package:flutter/cupertino.dart';
import 'package:flutter_healthcare_app/src/model/cart.dart';
import 'package:flutter_healthcare_app/src/model/medicine.dart';
import 'package:flutter_healthcare_app/src/model/medicine_type.dart';
import 'package:flutter_healthcare_app/src/model/registration_response.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EShopViewModel extends ChangeNotifier {
  Future<List<Medicine>> getAllMedicine(String medicineId, String medCompany,
      String medType, String productCategoryId) async {
    final response = await http.get(
        'http://172.16.61.221:8059/admins.asmx/getAllMedicine?MedicineId=$medicineId&MedCompany=$medCompany&medType=$medType&ProductCategoryId=$productCategoryId');

    if (response.statusCode == 200) {
      List<Medicine> medicines;

      Iterable list = json.decode(response.body);
      medicines = list.map((model) => Medicine.fromJson(model)).toList();

      return medicines;
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }

  Future<List<MedicineType>> getAllMedicineType() async {
    final response =
        await http.get('http://172.16.61.221:8059/admins.asmx/getMedicineType');

    if (response.statusCode == 200) {
      List<MedicineType> medicines;

      Iterable list = json.decode(response.body);
      medicines = list.map((model) => MedicineType.fromJson(model)).toList();

      return medicines;
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }

  Future<List<Cart>> getCart(String userId) async {
    final response =
    await http.get('http://172.16.61.221:8059/admins.asmx/viewMyCart?userId=$userId');

    if (response.statusCode == 200) {

      List<Cart> carts;

      Iterable list = json.decode(response.body);
      carts = list.map((model) => Cart.fromJson(model)).toList();

      return carts;
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }

  Future<RegistrationResponse> saveCart(String productId,String productName,String productCategoryId,String productCategoryName,String productPrice,String productQnty,String createdBy) async {
    final response = await http.get(
        'http://172.16.61.221:8059/admins.asmx/saveMyCart?productId=$productId&productName=$productName&productCategoryId=$productCategoryId&productCategoryName=$productCategoryName&productPrice=$productPrice&productQnty=$productQnty&createdBy=$createdBy');

    print(response.body);
    if (response.statusCode == 200) {
      return RegistrationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Exception: ${response.statusCode}');
    }
  }

}
