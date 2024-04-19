class Quote {
  String text;
  String author;

  Quote({ required this.text, required this.author});

  // Quote(String text, String author){
  //    this.text = text;
  //    this.author = author;
  // }


  // Quote(String text, String author){
  //   this.text = text;
  //   this.author = author;
  // }
}

Quote myQuote = Quote(author: 'ABC', text: 'This is the quote text');

// Quote myQuote = Quote('This is the quote text', 'ABC');