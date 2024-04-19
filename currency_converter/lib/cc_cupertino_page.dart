import 'package:flutter/cupertino.dart';

class CurrencyConverterCuppertinoPage extends StatefulWidget {
  const CurrencyConverterCuppertinoPage({super.key});

  @override
  State<CurrencyConverterCuppertinoPage> createState() => _CurrencyConverterCuppertinoPageState();
}

class _CurrencyConverterCuppertinoPageState extends State<CurrencyConverterCuppertinoPage> {
  double result = 0;
  double convertRate = 3.5; //MYR > SGD rate

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //App Background Color
      backgroundColor: CupertinoColors.systemGrey3,
      
      //header
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey3,
        middle: Text(
          "Currency Converter",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),

      //Body Section
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Show Result Section
              Text(
                'SGD ${result !=0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.black,
                ),
              ),

              //Spacing
              const SizedBox(height: 15),

              //Enter Amount TextField Section
              CupertinoTextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: CupertinoColors.black,
                ),

                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  
                ),

                prefix: const Icon(CupertinoIcons.money_dollar_circle),
                
                placeholder: 'Please Enter The Amount in MYR',

                clearButtonMode: OverlayVisibilityMode.always,
                padding: const EdgeInsets.all(13),
                
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              //Spacing
              const SizedBox(height: 15),

              //Convert TextButton Section
              SizedBox(
                width: 400,
                child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      result = double.parse(textEditingController.text) * convertRate;
                    });
                  },
              
                  color: CupertinoColors.systemGrey,
                  
                  child: const Text('Convert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
