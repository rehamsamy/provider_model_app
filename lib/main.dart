import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_model_app/add_product_screen.dart';
import 'package:provider_model_app/products.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // var _reference=FirebaseDatabase.instance.reference()
  // .child('path');
  //
  // _reference.set({'value':1});
  // print('xxxxxxx  ${_reference.get()}');
  


  runApp(ChangeNotifierProvider(
    child: MyApp(),
    create: (_)=>MyProvider(),
  ))
      ;
}


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppPage()
    );
  }
}

class MyAppPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Product> products=Provider.of<MyProvider>(context,listen: true).products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: products.length==0?Center(child: Text('Empty products'),):
          GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 500,
                  childAspectRatio: 2),
            children: products.map((e) =>  Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.file(e.image),
                            Container(
                              width: 200,
                              margin: EdgeInsets.fromLTRB(0, 50, 10, 10),
                              color: Colors.blueGrey.shade200,
                                child: Column(
                              children: [Text(e.title),
                                Text(e.desc),
                                  Text(e.price.toString())]
                            ))
                          ],
                        ),
    )).toList(),

          )
      ,floatingActionButton: Container(
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange,
        ),
        child: FlatButton.icon(onPressed: ()=>Navigator.push(context,
            MaterialPageRoute(builder: (_)=>AddProductScreen())), icon:
            Icon(Icons.add), label: Text('add product'))
      ),
    );
  }
}
