import 'package:bitcoin_ticker/NetworkHelper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
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

const apiKey = 'BEC75C86-3B32-48A3-B4F3-64ABF3DE53D7';

const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinPrice(String selectedCurrency) async {
    var url = '$baseUrl/BTC/$selectedCurrency?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var coinData = await networkHelper.getCoinData();
    return coinData;
  }
}
