import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // jsonDecode

const List<String> currenciesList = [
  'USD',
  'EUR',
  'GBP',
  'CNY',
  'BRL',
  'CAD',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'AUD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'XRP',
];

class CoinData {
  CoinData({@required this.url});
  final String url;

  Future getPrice() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print('Error getting data');
    }
  }
}
