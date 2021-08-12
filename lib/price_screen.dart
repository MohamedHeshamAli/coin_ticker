import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apik = 'e644d1f9d6194d72a6cf1072923b0815';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map currenciesMap;
  String CoinName1 = 'AED';
  String CoinName2 = 'AED';
  double price = 1;

  void UpdatecurrenciesMap() async {
    http.Response response = await http
        .get('https://openexchangerates.org/api/latest.json?app_id=$apik');

    currenciesMap = await jsonDecode(response.body)['rates'];
  }

  List<Text> IOSPicker() {
    List<Text> pickerItem = [];
    for (String currency in currenciesList)
      pickerItem.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    return pickerItem;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdatecurrenciesMap();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
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
                  '1 $CoinName1 = ${price.toStringAsFixed(3)} $CoinName2',
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'From:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                        child: CupertinoPicker(
                      itemExtent: 25.0,
                      onSelectedItemChanged: (n) {
                        setState(() {
                          CoinName1 = currenciesList[n];
                          price = currenciesMap[CoinName2] /
                              currenciesMap[CoinName1];
                        });
                        print(price);
                      },
                      children: IOSPicker(),
                      looping: false,
                      backgroundColor: Colors.lightBlue,
                    )),
                    Text(
                      'To:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                        child: CupertinoPicker(
                      itemExtent: 25.0,
                      onSelectedItemChanged: (n) {
                        setState(() {
                          CoinName2 = currenciesList[n];
                          price = currenciesMap[CoinName2] /
                              currenciesMap[CoinName1];
                        });
                        print(price);
                      },
                      children: IOSPicker(),
                      looping: false,
                      backgroundColor: Colors.lightBlue,
                    )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
//              Padding(
//                padding: EdgeInsets.symmetric(horizontal: 15.0),
//                child: Row(
//                  children: <Widget>[
//                    Text(
//                      'From:',
//                      style: TextStyle(
//                        fontSize: 20.0,
//                        color: Colors.white,
//                      ),
//                    ),
//                  ],
//                ),
//              )

// DropdownButton<String>(
//              isExpanded: false,
//              value: dropdownValue,
//              iconSize: 24,
//              elevation: 16,
//              onChanged: (String newValue) {
//                print(newValue);
//              },
//              items: [
//                DropdownMenuItem<String>(value: 'One', child: Text('One')),
//                DropdownMenuItem<String>(value: 'Two', child: Text('Two')),
//                DropdownMenuItem<String>(value: 'Free', child: Text('Free')),
//              ],
//            ),
