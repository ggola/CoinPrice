import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  CryptoCard({
    @required this.tickerName,
    @required this.tickerPrice,
    @required this.selectedCurrency,
  });

  final String tickerName;
  final double tickerPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color(0xFF124B5F), width: 0.7),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $tickerName = $tickerPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF124B5F),
            ),
          ),
        ),
      ),
    );
  }
}
