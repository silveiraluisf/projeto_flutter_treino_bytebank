import 'dart:convert';
import 'package:http/http.dart';
import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(baseUrl, 'transactions'));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(const Duration(seconds: 2));

    final Response response = await client.post(
        Uri.http(baseUrl, 'transactions'),
        headers: {'Content-type': 'application/json', 'password': password},
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(
      _getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if(_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode]!;
    }
    return 'unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exist',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
