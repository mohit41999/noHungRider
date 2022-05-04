import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rider_app/model/BeanAcceptOrder.dart';
import 'package:rider_app/model/BeanForgotPassword.dart';
import 'package:rider_app/model/BeanGetFeedback.dart';
import 'package:rider_app/model/BeanGetOrder.dart';
import 'package:rider_app/model/BeanGetProfile.dart';
import 'package:rider_app/model/BeanLogin.dart';
import 'package:rider_app/model/BeanSendFeedback.dart';
import 'package:rider_app/model/BeanSendMessage.dart';
import 'package:rider_app/model/BeanSignUp.dart';
import 'package:rider_app/model/BeanStartDelivery.dart';
import 'package:rider_app/model/BeanTripSummary.dart';
import 'package:rider_app/model/BeanWithdrawpayment.dart';
import 'package:rider_app/model/BeanrejectOrder.dart';
import 'package:rider_app/model/GetChat.dart';
import 'package:rider_app/model/GetCustomerFeedback.dart';
import 'package:rider_app/model/GetOrdeHistory.dart';
import 'package:rider_app/model/GetOrderDetails.dart';
import 'package:rider_app/model/GetOverAllReview.dart';
import 'package:rider_app/model/bankAccountModel.dart';
import 'package:rider_app/model/getCureentOrders.dart';
import 'package:rider_app/screen/TripSummaryScreen.dart';
import 'package:rider_app/utils/DioLogger.dart';

import 'EndPoints.dart';

class ApiProvider {
  static const _baseUrl =
      "https://nohungkitchen.notionprojects.tech/api/rider/";
  static const String TAG = "ApiProvider";

  Dio _dio;
  DioError _dioError;

  ApiProvider() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = ApiProvider._baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers = {
        'Content-Type': 'multipart/form-data',
      };
      DioLogger.onSend(TAG, options);
      return options;
    }, onResponse: (Response response) {
      DioLogger.onSuccess(TAG, response);
      return response;
    }, onError: (DioError error) {
      DioLogger.onError(TAG, error);
      return error;
    }));
  }

  Future registerUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.register, data: params);

      return BeanSignUp.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future AddBankAccount(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_account_detail, data: params);
      return jsonDecode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getBankAccounts(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_bank_accounts, data: params);
      return BankAccountsModel.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future editBankAccounts(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.edit_bank_account, data: params);
      return json.decode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future deleteBankAccounts(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.delete_bank_account, data: params);
      return json.decode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getFeedback(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_received_reviews, data: params);
      return BeanGetFeedback.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getOrderDetails(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_order_detail, data: params);
      return GetOrderDetails.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getOrder(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_orders, data: params);
      return BeanGetOrder.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future rejectOrder(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.reject_order, data: params);
      return BeanRejectOrder.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future acceptOrder(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.accept_order, data: params);
      return BeanAcceptOrder.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getCustomerFeedback(FormData params) async {
    try {
      Response response = await _dio.post(
          EndPoints.get_customer_feedback_improvement_options,
          data: params);
      return GetCustomerFeedback.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getProfile(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_my_profile, data: params);
      return GetProfile.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future withdrawPayment(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.whitdraw_payment, data: params);
      return BeanWithdrawpayment.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getOverAllReview(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_overall_received_reviews, data: params);
      return GetOverAllReview.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getChat(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_chat, data: params);
      return GetChat.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getOrderHistory(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.order_history, data: params);
      return GetOrderHistory.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future loginUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.login, data: params);
      return BeanLogin.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getState(FormData params) async {
    Response response = await _dio.post(EndPoints.get_state, data: params);
    return json.decode(response.data);
  }

  Future getCity(FormData params) async {
    Response response = await _dio.post(EndPoints.get_city, data: params);
    return json.decode(response.data);
  }

  Future sendFeedback(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.send_customer_feedback, data: params);
      return BeanSendFeedback.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future tripSummary(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.trip_summary, data: params);
      return BeanTripSummary.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future sendMessage(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.send_message, data: params);
      return BeanSendMessage.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanForgotPassword> forgotPassword(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.forgot_password, data: params);
      return BeanForgotPassword.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future starDelivery(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.start_delivery, data: params);
      return BeanStartDelivery.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateOrderTrack(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_order_track, data: params);
      return BeanStartDelivery.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getCurrentOrders(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_current_orders, data: params);
      return GetCurrentOrdersModel.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future delivered(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.delivered, data: params);
      return jsonDecode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  void throwIfNoSuccess(String response) {
    throw new HttpException(response);
  }
}
