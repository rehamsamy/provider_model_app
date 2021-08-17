
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_model_app/products.dart';
//import 'package:toast/toast.dart';


class AddProductScreen extends StatelessWidget {
  var titleController=TextEditingController();
  var descController=TextEditingController();
  var priceController=TextEditingController();
  File image=File('im');
  @override
  Widget build(BuildContext context) {
    //MyProvider prov= Provider.of<MyProvider>(context,listen: false);

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Add product'),
          ),
          body:Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                  controller: titleController,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'description'
                  ),
                  controller: descController,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'price'
                  ),
                  controller: priceController,
                ),
                SizedBox(height: 20,),
                RaisedButton(padding:EdgeInsets.all(15),onPressed:() =>chooseImage(context),color: Colors.lightBlue,
                  child: Text('choose image',style: TextStyle(fontSize: 18,color: Colors.white),),
                ),
                SizedBox(height: 20,),
                   RaisedButton(padding:EdgeInsets.all(15),onPressed:()=>getProductData(context)
                   ,color: Colors.orangeAccent,
                    child: Text('Add Product',style: TextStyle(fontSize: 18,color: Colors.black),),
                  )
              ],
            ),
          ) ,
        ),

    );
  }


  void getProductData(BuildContext context) {

    double price=0;
    if (titleController.text.isEmpty || descController.text.isEmpty ||
        priceController.text.isEmpty) {
      //Toast.show('no image selected ', context,duration: Toast.LENGTH_LONG);
      print('enter data');
    } else if (image == null) {
      print('please choose image');
    }
    try {
      price = double.parse(priceController.text);
    }
    catch (e) {
      print(e);
    }
    Provider.of<MyProvider>(context,listen: false).addProducts(titleController.text, descController.text, price, image);
    Navigator.pop(context);
    print(Provider.of<MyProvider>(context).products.length);

  }
  void chooseImage(BuildContext ctx) {
    showDialog(context: ctx, builder: (ctx){
      return AlertDialog(
        title: Text('choose image :'),
        content: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              color: Colors.blueGrey,
              height: 40,
              child: ListTile(onTap:()async=>await getImage(ImageSource.gallery,ctx), title: Text('gallery'),
                  leading: Icon(Icons.image)
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              color: Colors.blueGrey,
              height: 40,
              child: ListTile(onTap:()async=>await getImage(ImageSource.camera,ctx), title: Text('Camera'),
                leading: Icon(Icons.add_a_photo),
               ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      );

    });
  }

  getImage(ImageSource src,BuildContext context) async {
    var picker = await ImagePicker().pickImage(source: src);
    if (picker != null) {
      image=File(picker.path);
      print('image selected ${image.path}');
    }else{
      print('error');
     // Toast.show('no image selected ', context,duration: Toast.LENGTH_LONG);
    }
  }

}

