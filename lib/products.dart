import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Product{
  final String title;
  final String desc;
  final double price;
  final File image;

  Product({@required this.title,@required this.desc, @required this.price,@required  this.image});

}

class MyProvider with ChangeNotifier{
  List<Product> products=[];

  //DatabaseReference _ref=FirebaseDatabase.instance.reference().child('product');
  String url='https://provider-9e068-default-rtdb.firebaseio.com/product.json';


  void addProducts(String title,String desc,double price,File image){

    http.post(Uri.parse(url),body: json.encode({'title':title,'des':desc,'price':price}),);

    products.add(Product(title: title, desc: desc, price: price, image: image));
    notifyListeners();
  }
}