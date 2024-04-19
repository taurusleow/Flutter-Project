import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() => _CurrencyConverterMaterialPage();
}

class _CurrencyConverterMaterialPage extends State<CurrencyConverterMaterialPage>{
  //Variables initialization
  double result = 0;
  double convertRate = 3.5; //MYR > SGD rate

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() { //Dispose method to get rid of widget, to avoid memory leaks. Gets call after the entire widget gonna get discarded.
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Design of OutlineInputBorder
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
        color: Colors.white54,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      //App Background Color
      backgroundColor: Colors.blueGrey,
      
      //header
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text(
          "Currency Converter",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),

      //Body Section
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Show Result Section
              Text(
                'SGD ${result!=0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              //Spacing
              const SizedBox(height: 15),

              //Enter Amount TextField Section
              TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.white54,

                  hintText: 'Please enter the amount in MYR',
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),

                  suffixIcon: IconButton(
                    onPressed: textEditingController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  
                  suffixIconColor: Colors.white54,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              //Spacing
              const SizedBox(height: 15),

              //Convert TextButton Section
              TextButton(
                onPressed: () {
                  setState(() {
                    result = double.parse(textEditingController.text) * convertRate;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
