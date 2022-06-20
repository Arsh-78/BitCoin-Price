import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  String priceCurBTC = '? USD';
  String priceCurETH = '? USD';
  String priceCURLTC = '? USD';
  String coinName = "BTC";

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String item in currenciesList) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          child: Text(item),
          value: item,
        ),
      );
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(() async {
          selectedCurrency = value;
          List<dynamic> allCoinData = [];
          for (String coin in cryptoList) {
            var coindata = await coinData.getCoinPrice(selectedCurrency, coin);
            allCoinData.add(coindata);
          }
          updateUI(allCoinData);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickermenuItems = [];
    for (String item in currenciesList) {
      pickermenuItems.add(Text(item));
    }

    return CupertinoPicker(
      onSelectedItemChanged: (selectedIndex) async {
        setState(() async {
          selectedCurrency = currenciesList[selectedIndex];
          List<dynamic> allCoinData = [];
          for (String coin in cryptoList) {
            var coindata = await coinData.getCoinPrice(selectedCurrency, coin);
            allCoinData.add(coindata);
          }

          updateUI(allCoinData);
        });
      },
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      children: pickermenuItems,
    );
  }

/*  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else {
      return androidPicker();
    }
  } replaced with ternanry operator*/

  void updateUI(List<dynamic> coinData) {
    setState(() {
      if (coinData == null) {
        print('Some Error');
      }

      priceCurBTC = coinData[0]['rate'].toStringAsFixed(2);
      priceCurETH = coinData[1]['rate'].toStringAsFixed(2);
      priceCURLTC = coinData[2]['rate'].toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<dynamic> allCoinUSDdata = [];
    for (String coin in cryptoList) {
      var coindata = await coinData.getCoinPrice('USD', coin);
      allCoinUSDdata.add(coindata);
    }

    updateUI(allCoinUSDdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $priceCurBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $priceCurETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $priceCURLTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
