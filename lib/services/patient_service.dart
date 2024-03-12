import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mapd722_group2_project/models/create_patient_model.dart';
import 'package:mapd722_group2_project/models/patient_critical_model.dart';
import 'package:mapd722_group2_project/models/patient_detail_model.dart';
import 'package:mapd722_group2_project/models/patient_list_model.dart';
import 'package:mapd722_group2_project/models/update_patient_model.dart';

class PatientService {
  static const String baseUrl = "http://127.0.0.1:4000";
// Replace with your server-side API endpoint for MongoDB
  static const String mongodbUrl =
      "mongodb+srv://jeetkaur941:zgwueYu2YovUMcAy@harvar.v8ovqmx.mongodb.net/Harvar?retryWrites=true&w=majority";

  static Future<CreatePatientModel> createNewPatient({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String address,
    required String sex,
    required String dob,
  }) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Content-Type': "application/json",
      };
      print(firstName);
      print(lastName);
      print(email);
      print(mobileNumber);
      print(address);
      print(sex);
      print(dob);

      final response = await http.post(
        Uri.parse('$baseUrl/patients'),
        headers: headers,
        body: jsonEncode(<String, String>{
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "mobile_number": mobileNumber,
          "address": address,
          "sex": sex,
          "date_of_birth": dob
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      switch (response.statusCode) {
        case 200:
          return createPatientModelFromJson(response.body);
        case 201:
          return createPatientModelFromJson(response.body);
        case 500:
          print("failed 1");
          throw ("Failed to create patient");
        default:
          print("failed 2");
          throw ("Failed to create patient");
      }
    } on SocketException catch (_) {
      throw ('No Internet connection available');
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      print("failed 3");
      throw ("Failed to create patient");
    }
  }

  static Future<List<PatientListModel>> getPatientLists() async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Content-Type': "application/json",
      };

      final response = await http.get(
        Uri.parse('$baseUrl/patients'),
        headers: headers,
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      switch (response.statusCode) {
        case 200:
          return patientListModelFromJson(response.body);
        case 201:
          return patientListModelFromJson(response.body);
        case 500:
          throw ("Failed to load data");
        default:
          throw ("Failed to load data");
      }
    } on SocketException catch (_) {
      throw ('No Internet connection available');
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw ("Failed to load data");
    }
  }

  static Future<List<PatientCriticalModel>>
      getPatientsWithCriticalConditions() async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Content-Type': "application/json",
      };

      final response = await http.get(
        Uri.parse('$baseUrl/patients/conditions'),
        headers: headers,
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      switch (response.statusCode) {
        case 200:
          return patientCriticalModelFromJson(response.body);
        case 201:
          return patientCriticalModelFromJson(response.body);
        case 500:
          throw ("Failed to load data");
        default:
          throw ("Failed to load data");
      }
    } on SocketException catch (_) {
      throw ('No Internet connection available');
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw ("Failed to load data");
    }
  }

  static Future<List<PatientDetailModel>> getPatientDetails({
    required String patientId,
  }) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Content-Type': "application/json",
      };

      final response = await http.get(
        Uri.parse('$baseUrl/patients/$patientId'),
        headers: headers,
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      switch (response.statusCode) {
        case 200:
          return patientDetailModelFromJson(response.body);
        case 201:
          return patientDetailModelFromJson(response.body);
        case 500:
          throw ("Failed to load data");
        default:
          throw ("Failed to load data");
      }
    } on SocketException catch (_) {
      throw ('No Internet connection available');
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw ("Failed to load data");
    }
  }

  static Future<UpdatePatientModel> updatePatient({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String address,
    required String sex,
    required String dob,
    required String patientId,
  }) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        'Content-Type': "application/json",
      };

      final response = await http.put(
        Uri.parse('$baseUrl/patients/$patientId'),
        headers: headers,
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "mobile_number": mobileNumber,
          "address": address,
          "sex": sex,
          "date_of_birth": dob
        }),
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      switch (response.statusCode) {
        case 200:
          return updatePatientModelFromJson(response.body);
        case 201:
          return updatePatientModelFromJson(response.body);
        case 500:
          throw ("Failed to update patient");
        default:
          throw ("Failed to update patient");
      }
    } on SocketException catch (_) {
      throw ('No Internet connection available');
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw ("Failed to update patient");
    }
  }
}
