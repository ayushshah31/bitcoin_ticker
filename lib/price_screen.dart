import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency='AUD';
  CoinData cd = CoinData();
  List<int> price = [];

  DropdownButton getDropDownItems(){
    List<DropdownMenuItem<String>> dropdownList = [];
    for(String currency in currenciesList)
      {
        var newItem = DropdownMenuItem(
            child: Text(currency),
          value: currency,
        );
        dropdownList.add(newItem);
      }
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
      },
      items: dropdownList,
    );
  }

  CupertinoPicker getCupertinoPicker(){
    List<Text> pickerList = [];
    for(String currency in currenciesList)
      {
        pickerList.add(Text(currency));
      }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 25.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
        getPrice();
        },
      children: pickerList,
    );
  }

  void getPrice() async{
    for(String coin in cryptoList)
      {
        price.add(await cd.getCoinPrice(coin,selectedCurrency));
      }
    setState(() {
      price=price;
    });
    // updatePrice(price);
  }

  List<Widget> cardList(){
    List<Card> newList = [];
    int i=0;
    for(String coin in cryptoList)
      {
        newList.add(Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 70.0),
            child: Text(
              '1 $coin = ${price.isEmpty?'?':price[i]} $selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ));
        i++;
      }
    return newList;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: cardList(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getCupertinoPicker()
          ),
        ],
      ),
    );
  }
}