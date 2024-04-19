// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() => runApp(MaterialApp(
  home: QuoteList(),
));

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  List<Quote> quotes = [
    Quote(author: 'ABC', text: 'ABC'),
    Quote(author: 'ABC', text: 'ABC'),
    Quote(author: 'ABC', text: 'ABC'),
  ];

  // Widget quoteTemplate(quote){
  //   return QuoteCard(quote: quote);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: quotes.map((quote) => QuoteCard(
          quote: quote,
          delete: () {
            setState(() {
              quotes.remove(quote);
            });
          }
        )).toList(),
        
        //quotes.map((quote) => QuoteCard(quote: quote)).toList(),

        //If have one line of funtion only can use this method
        //quotes.map((quote) => Text('${quote.text} - ${quote.author}')).toList(),

        //If have more than one functions can use this method
        // quotes.map((quote) {
        //   return Text(quote);
        // }).toList(),
      )
    );
  }
}
