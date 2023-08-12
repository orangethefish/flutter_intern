import 'package:http/http.dart' as http;
import 'dart:convert';

//constants
String ipAdd='192.168.4.52';
String apiHost='$ipAdd:5000';

class Item{
  final int id;
  final String prodName;
  final double prodPrice;
  final String image;

  Item({
    required this.id,
    required this.prodName,
    required this.prodPrice,
    required this.image
  });
}

Future <List> getCategory() async{
  try {
    var url = Uri.http(apiHost, 'products/category');
    final response = await http.get(url);
    List data = jsonDecode(response.body);
    data.insert(0, 'All');
    return data;
  }
  catch(e){
    print(e);
    return [];
  }
}
Future<Map<String, List<Item>>> getItems() async{
  Map<String,List<Item>> itemsMap={};
  List categories= await getCategory();
  for(String category in categories){
    try {
      var url = Uri.http(apiHost, 'products/filter&$category');
      final response = await http.get(url);
      List<dynamic> itemList = jsonDecode(response.body); // List of dynamic objects
      List<Item> itemsForCategory = itemList.map((itemJson) {
        return Item(
          id: itemJson['id'], // Assuming your JSON structure has 'id', 'prodName', 'prodPrice', etc.
          prodName: itemJson['prodName'],
          prodPrice: itemJson['prodPrice'],
          image: itemJson['image']
        );
      }).toList();
      itemsMap[category] = itemsForCategory;
    }
    catch(e){
      print(e);
      itemsMap[category]=[];
    }
  }
  // itemsMap.forEach((key, value) {
  //   print('Key: $key, Value: $value');
  // });
  return itemsMap;
}
Future <void> addItemToCart(Item item) async{
  try{
    var url=Uri.http(apiHost, 'cart/add-to-cart');
  }catch(e){

  }
}