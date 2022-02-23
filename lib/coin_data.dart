import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'EUR',
  'GBP',
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
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<int> getCoinPrice(String coinName , String currency) async {
    String url = 'https://rest.coinapi.io/v1/exchangerate/$coinName/$currency?apikey=1B20F57E-08B7-46AF-A752-9A39BB2F3AF2';
    dynamic coinData = await http.get(Uri.parse(url));
    coinData = jsonDecode(coinData.body);
    var price = coinData["rate"];
    print(price.toInt()??"-");
    return price.toInt()??0;
  }

}
