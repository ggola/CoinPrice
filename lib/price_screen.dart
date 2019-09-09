import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'spinning_bubble.dart';
import 'crypto_card.dart';

const url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selCur;
  bool isDataArrived = false;
  bool isDataRefreshed = false;
  Map<String, double> coinPrice;

  // Cupertino Picker
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      squeeze: 1,
      useMagnifier: true,
      magnification: 1.1,
      backgroundColor: Color(0xFF124B5F),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        getPriceData();
        await Future.delayed(Duration(milliseconds: 700), () {
          setState(() {
            isDataRefreshed = true;
          });
        });
      },
      children: pickerItems,
    );
  }

  // Android picker
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency, // specify first item in the list to show
      items: dropdownItems,
      onChanged: (value) async {
        selectedCurrency = value;
        getPriceData();
        await Future.delayed(Duration(milliseconds: 700), () {
          setState(() {
            isDataRefreshed = true;
          });
        });
      },
    );
  }

  // Networking
  void getPriceData() async {
    Map<String, double> price = {};

    for (String ticker in cryptoList) {
      String finalUrl = '$url$ticker$selectedCurrency';
      CoinData coinData = CoinData(url: finalUrl);
      var priceData = await coinData.getPrice();
      price[ticker] = priceData['bid'];
    }
    setState(() {
      isDataArrived = true;
      isDataRefreshed = false;
      coinPrice = price;
      selCur = selectedCurrency;
    });
  }

  @override
  void initState() {
    super.initState();
    getPriceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coin Ticker',
          style: TextStyle(fontSize: 23.0),
        ),
      ),
      body: isDataArrived
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: isDataRefreshed
                  ? <Widget>[
                      Expanded(child: SpinningBubble()),
                      Container(
                        height: 150.0,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 30.0),
                        color: Color(0xFF124B5F),
                        child: Platform.isIOS ? iOSPicker() : androidDropdown(),
                      ),
                    ]
                  : <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: getCryptoCards(),
                      ),
                      Container(
                        height: 150.0,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 30.0),
                        color: Color(0xFF124B5F),
                        child: Platform.isIOS ? iOSPicker() : androidDropdown(),
                      ),
                    ],
            )
          : SpinningBubble(),
    );
  }

  List<CryptoCard> getCryptoCards() {
    List<CryptoCard> cryptoCards = [];
    for (String ticker in cryptoList) {
      CryptoCard card = CryptoCard(
          tickerName: ticker,
          tickerPrice: (coinPrice[ticker] ?? 0.0),
          selectedCurrency: (selCur ?? selectedCurrency));
      cryptoCards.add(card);
    }
    return cryptoCards;
  }
}
