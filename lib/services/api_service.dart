import 'package:http/http.dart' as http;
import 'dart:convert';

//constants
String ipAdd='192.168.4.52'; //ip address
String apiHost='$ipAdd:5000'; //port that backend listening to

class Item{ // item for product
  final int id;
  final String prodName;
  final double prodPrice;
  final String image;
  final String prodCategory;

  Item({
    required this.id,
    required this.prodName,
    required this.prodPrice,
    required this.image,
    required this.prodCategory,
  });
}
class CartItem extends Item { //item for a cart (added quantity and subtotal)
  final int quantity;
  final double subtotal;

  CartItem({
    required int id,
    required String prodName,
    required double prodPrice,
    required String image,
    required this.quantity,
    required this.subtotal,
  }) : super(
    id: id,
    prodName: prodName,
    prodPrice: prodPrice,
    image: image,
    prodCategory: '',
  );
}


Future <List> getCategory() async{ //fetch list of categories
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
Future<Map<String, List<Item>>> getItems() async{ //fetch items within a category
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
            prodCategory: itemJson['prodCategory'],
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

Future<List<CartItem>> getCart()async{//fetch items in cart
  try{
    var url=Uri.http(apiHost,'cart/all');
    final response= await http.get(url);
    List<dynamic> cartList = jsonDecode(response.body);
    List<CartItem> cartItems = cartList.map((item) {
      return CartItem(
        id: item['id'],
        prodName: item['prodName'],
        prodPrice: item['prodPrice'],
        image: item['image'],
        quantity: item['quantity'],
        subtotal: item['subtotal'].toDouble(),
      );
    }).toList();

    return cartItems;
  }catch(e){
    print(e);
    return [];
  }
}
Future <void> addItemToCart(Item item, int quantity) async{ //add or remove item from cart
  try{
    var url=Uri.http(apiHost, 'cart/add-to-cart');
    var subtotal = item.prodPrice*quantity;
    await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': item.id,
        'prodName': item.prodName,
        'prodPrice': item.prodPrice,
        'quantity': quantity,
        'subtotal': subtotal,
        'image': item.image
      }),
    );
  }catch(e){
    print(e);
  }
}