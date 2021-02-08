import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'price_screen.dart';
import 'package:bitcoin_ticker/networking.dart';
import 'dart:convert';

const apiKey = '9085D930-2B50-485A-9801-2D6752F12F00#';

const url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey';
const List<String> currenciesList = ['AUD', 'BRL', 'CAD', 'CNY', 'EUR', 'GBP', 'HKD', 'IDR', 'ILS', 'INR', 'JPY', 'MXN', 'NOK', 'NZD', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'USD', 'ZAR'];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  dynamic rate = ['rate'];
  Future<void> getCoinData() async {
    http.Response response = await http.get(url);
    print(response.statusCode);
    print(rate);
    if (response.statusCode == 200) {
      // данное условие обеспечивает нас увереность что он запуститься
      // status 200 означает что есть связь с http
      String data = response.body; // тут у нас тело нашего http
      return jsonDecode(data);
    } else {
      print(response.statusCode); // тут узазывает статус есть сылка где можно проверить
    }
  }

  Future<dynamic> updateUi(dynamic coin) async {
    dynamic price = await coin('rate');
    print(price);
    return price;
  }
}
